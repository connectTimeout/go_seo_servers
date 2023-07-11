import 'package:flutter/material.dart';

///布局方式
class ITextListCell extends StatelessWidget {
  const ITextListCell({
    super.key,
    required this.title,
    required this.children,
    this.padding,
    this.width,
    this.alignment,
    this.titleColor,
    this.isfontWeight = false,
  });

  final String title;
  final Color? titleColor;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final AlignmentGeometry? alignment;
  final bool isfontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width ?? 100,
            padding: const EdgeInsets.only(top: 4, right: 10),
            alignment: alignment ?? Alignment.centerRight,
            child: Text(
              "$title：",
              style: isfontWeight
                  ? null
                  : const TextStyle(
                      color: Color.fromARGB(129, 4, 24, 14),
                      fontWeight: FontWeight.bold,
                    ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Wrap(
              spacing: 4, // 横向间距
              runSpacing: 10, //纵向间距
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class ITextField extends StatelessWidget {
  const ITextField({
    super.key,
    this.controller,
    this.width,
    this.height,
    this.maxLines = 5,
    this.hintText = '请输入',
    this.enabled,
    this.onSubmitted,
  });

  final String? hintText;
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final int? maxLines;
  final bool? enabled;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    var widths = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width ?? widths * 0.4 * 0.5,
      height: height,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        enabled: enabled,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, left: 5),
          hintText: hintText,
          border: const OutlineInputBorder(
            gapPadding: 50,
          ),
        ),
      ),
    );
  }
}

class IRadioFileList extends StatelessWidget {
  const IRadioFileList({
    super.key,
    this.value,
    required this.title,
    this.isRadio = false,
    this.onChanged,
    this.groupValue,
  });
  final dynamic value;
  final String title;
  final bool isRadio;
  final ValueChanged<dynamic>? onChanged;
  final dynamic groupValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            onChanged: isRadio ? onChanged : null,
          ),
          Text(title),
        ],
      ),
    );
  }
}
