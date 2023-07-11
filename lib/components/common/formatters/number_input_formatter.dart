import 'package:flutter/services.dart';

///
/// @author xbwca
/// @description: TextField限制输入num
/// @date :2022/2/12 23:06
///
class NumberInputFormatter extends TextInputFormatter {
  final int? maxIntegerLength;
  final int maxDecimalLength;
  final bool isAllowDecimal;
  final bool isAllowNegative;
  final num? min;
  final num? max;

  /// [maxIntegerLength]限定整数的最大位数，为null时不限
  /// [maxDecimalLength]限定小数的最大位数，默认限制两位小数
  /// [min]限定最小值
  /// [max]限定最大值
  /// [isAllowDecimal]是否可以为小数,默认true
  /// [isAllowNegative]是否可以为负数,默认false
  NumberInputFormatter({
    this.maxIntegerLength,
    this.isAllowDecimal = true,
    this.min,
    this.max,
    this.maxDecimalLength = 2,
    this.isAllowNegative = false,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 去掉所有非法字符
    String value = newValue.text.replaceAll(
      RegExp("[^0-9${isAllowDecimal ? '.' : ''}${isAllowNegative ? '-' : ''}]"),
      "",
    );
    // 非法字符数
    int invalidCount = newValue.text.length - value.length;
    int selectionIndex = newValue.selection.end - invalidCount;
    if (isAllowNegative && value == '-') {
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
    if (isAllowDecimal) {
      if (value == '.') {
        value = '0.';
        selectionIndex++;
      } else if (value == '-.') {
        value = '-0.';
        selectionIndex++;
      } else if (value != '' && _isToDoubleError(value)) {
        return _oldTextEditingValue(oldValue);
      }
      // 包含小数点
      if (value.contains('.')) {
        int pointIndex = value.indexOf('.');
        String beforePoint = value.substring(0, pointIndex);
        String afterPoint = value.substring(pointIndex + 1, value.length);
        // 小数点前面没内容补0
        if (beforePoint.isEmpty) {
          value = '0.$afterPoint';
          selectionIndex++;
        } else {
          // 限定整数位数
          if (maxIntegerLength is int) {
            if (beforePoint.length > maxIntegerLength!) {
              return _oldTextEditingValue(oldValue);
            }
          }
        }
        // 限定小数点位数
        if (afterPoint.length > maxDecimalLength) {
          return _oldTextEditingValue(oldValue);
        }
      } else {
        //限定整数位数
        if (maxIntegerLength is int) {
          if (value.length > maxIntegerLength!) {
            return _oldTextEditingValue(oldValue);
          }
        }
      }
    } else {
      if (value.contains('.') ||
          (value != '' && _isToDoubleError(value)) ||
          (maxIntegerLength is int && maxIntegerLength! < value.length)) {
        return _oldTextEditingValue(oldValue);
      }
    }
    // 边界值限制
    if ((max is num && (num.tryParse(value) ?? 0) > max!) ||
        min is num && (num.tryParse(value) ?? 0) < min!) {
      return _oldTextEditingValue(oldValue);
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  /// 返回旧的输入内容
  TextEditingValue _oldTextEditingValue(TextEditingValue oldValue) {
    return TextEditingValue(
      text: oldValue.text,
      selection: TextSelection.collapsed(offset: oldValue.selection.end),
    );
  }

  /// 输入内容不能解析成double
  bool _isToDoubleError(String value) {
    try {
      double.parse(value);
    } catch (e) {
      return true;
    }
    return false;
  }
}
