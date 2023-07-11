import 'package:flutter/material.dart';

class VariousStatelessButton extends StatelessWidget {
  final String? title;
  final Icon? icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final BorderRadiusGeometry? radius;
  final double? fontSize;
  final BorderSide? border;
  final EdgeInsetsGeometry? padding;
  const VariousStatelessButton({
    super.key,
    this.title,
    this.icon,
    this.color,
    this.textColor,
    this.radius,
    this.onPressed,
    this.fontSize,
    this.border,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(padding),
        backgroundColor: MaterialStateProperty.all(
          color ?? const Color.fromARGB(255, 240, 240, 240),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: radius ?? BorderRadius.circular(5.0),
              side: border ?? BorderSide.none),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: icon == null ? 0 : 5, top: 3),
              child: icon ?? const SizedBox(),
            ),
            Text(
              title ?? '',
              style: TextStyle(
                  color: textColor ?? Colors.black, fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
