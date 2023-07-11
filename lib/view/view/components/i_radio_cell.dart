import 'package:flutter/material.dart';
import 'package:go_seo_servers/view/seo.dart';

class ITextRadios extends StatelessWidget {
  const ITextRadios({
    super.key,
    this.title,
    required this.value,
    this.onChanged,
    this.groupValue,
  });

  final String? title;
  final dynamic value;
  final ValueChanged<HttpOption?>? onChanged;
  final HttpOption? groupValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<HttpOption>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(title ?? ''),
          ),
        ],
      ),
    );
  }
}
