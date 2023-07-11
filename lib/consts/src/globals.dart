import 'package:flutter/material.dart';

class Globals {
  const Globals._();

  static Color? a = const Color.fromARGB(255, 179, 242, 194);
  static Color? b = const Color.fromARGB(255, 1, 12, 45);

  /// dart blue
  static Color? oceanBlue = Color.lerp(a, b, 0.4);

  ///常用间距
  ///

  ///按钮背景色
  static Color? greenBackgColor = const Color.fromARGB(255, 243, 255, 244);
  static Color? blueBackgColor = const Color.fromARGB(255, 245, 247, 255);
  static Color? redBackgColor = const Color.fromARGB(255, 255, 243, 243);
  static Color? greyBackgColor = const Color.fromARGB(255, 247, 247, 247);

  ///按钮边框色
  static Color greenBorderColor = const Color.fromARGB(255, 208, 248, 209);
  static Color? blueBorderColor = const Color.fromARGB(255, 223, 229, 248);
  static Color? redBorderColor = const Color.fromARGB(255, 255, 206, 206);
  static Color? greyBorderColor = const Color.fromARGB(255, 199, 199, 199);

  ///按钮文字颜色
  static Color? greenTextColor = const Color.fromARGB(255, 0, 253, 8);
  static Color? blueTextColor = const Color.fromARGB(255, 96, 133, 245);
  static Color? redTextColor = const Color.fromARGB(255, 236, 80, 80);
  static Color? greyTextColor = const Color.fromARGB(255, 102, 102, 102);

  ///数据表格颜色
  static MaterialStateProperty<Color?> statesColor =
      MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.white;
    }
    return Colors.white;
  });
}
