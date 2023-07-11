import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ITooltip extends StatelessWidget {
  final String message;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final double? size;
  final Color? color;

  const ITooltip({
    super.key,
    required this.message,
    this.icon,
    this.padding,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      textAlign: TextAlign.center,
      message: message,
      child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
          child: Icon(
            icon ?? CupertinoIcons.question_circle_fill,
            size: size ?? 16,
            color: color ?? Colors.green,
          )),
    );
  }
}
