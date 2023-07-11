import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_seo_servers/components/components.dart';

///
/// @author xbwca
/// @description: 数字输入框,可加减
/// @date :2022/2/11 17:46
///
const double _kMaxHeight = 32.0;

const double _kMaxWidth = 152.0;

const double _kIconWidth = 30;

const BorderSide _borderSide = BorderSide(width: 1, color: Colors.black12);

class NumberInputWidget extends StatefulWidget {
  NumberInputWidget({
    super.key,
    TextEditingController? controller,
    num? defaultVal,
    List<TextInputFormatter>? inputFormatters,
    bool? readOnly,
    bool? decimal,
    this.addValueChanged,
    this.subtractValueChanged,
    this.updateValueChanged,
  })  : defaultVal = defaultVal ?? 0,
        readOnly = readOnly ?? false,
        decimal = decimal ?? true,
        controller = controller ?? TextEditingController(),
        inputFormatters =
            inputFormatters ?? [NumberInputFormatter(maxDecimalLength: 2)];

  final TextEditingController controller;

  /// 默认值
  final num defaultVal;

  /// ios键盘是否显示小数点
  final bool decimal;

  final bool readOnly;

  /// 点击加号回调
  final ValueChanged? addValueChanged;

  /// 点击减号回调
  final ValueChanged? subtractValueChanged;

  /// 变化回调
  final ValueChanged? updateValueChanged;

  final List<TextInputFormatter> inputFormatters;

  @override
  State<NumberInputWidget> createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends State<NumberInputWidget> {
  FocusNode focusNode = FocusNode();

  late num oldData = widget.defaultVal;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty) {
      widget.controller.text = widget.defaultVal.toString();
    }
    widget.controller.addListener(() {
      var val = num.tryParse(widget.controller.text);
      if (oldData != val) {
        widget.updateValueChanged?.call(val);
        oldData = val ?? widget.defaultVal;
      }
    });
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        widget.controller.text =
            num.tryParse(widget.controller.text)?.toString() ??
                widget.defaultVal.toString();
      }
    });
  }

  /// 精度问题,转换成整数运算后再转换回来
  num handleNum(num val, bool isAdd) {
    if (val is int) {
      return isAdd ? val + 1 : val - 1;
    }
    if (val is double) {
      var temp = pow(10, val.toString().split('.')[1].length);
      var valInt = (val * temp).floor();
      return (isAdd ? valInt + temp : valInt - temp) / temp;
    }
    return val;
  }

  void onBtnClick(bool isAdd) {
    var nums = num.tryParse(widget.controller.text) ?? 0;
    if (!isAdd && nums < 1) return;
    nums = handleNum(nums, isAdd);
    if (isAdd) {
      widget.addValueChanged?.call(nums);
    } else {
      widget.subtractValueChanged?.call(nums);
    }
    setState(() {
      widget.controller.text = '$nums';
      // 光标保持在文本末尾
      var length = widget.controller.text.length;
      widget.controller.selection = TextSelection(
        baseOffset: length,
        extentOffset: length,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.readOnly ? .5 : 1,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: _kMaxHeight,
          maxWidth: _kMaxWidth,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: Row(
          children: <Widget>[
            customIconButton(Icons.remove, false),
            Expanded(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    left: _borderSide,
                    right: _borderSide,
                  ),
                ),
                child: TextField(
                  controller: widget.controller,
                  focusNode: focusNode,
                  readOnly: widget.readOnly,
                  keyboardType:
                      TextInputType.numberWithOptions(decimal: widget.decimal),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                  enableInteractiveSelection: false,
                  inputFormatters: widget.inputFormatters,
                  onChanged: (val) => setState(() {}),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(2),
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            customIconButton(Icons.add, true),
          ],
        ),
      ),
    );
  }

  Widget customIconButton(IconData icon, bool isAdd) {
    bool disabled = widget.readOnly ||
        ((num.tryParse(widget.controller.text) ?? 0) < 1 && !isAdd);
    return SizedBox(
      width: _kIconWidth,
      child: CupertinoButton(
        onPressed: disabled ? null : () => onBtnClick(isAdd),
        padding: const EdgeInsets.all(0),
        child: Icon(
          icon,
          size: 20,
          color: disabled
              ? Theme.of(context).dividerColor
              : Theme.of(context).hintColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    focusNode.removeListener(() {});
    super.dispose();
  }
}
