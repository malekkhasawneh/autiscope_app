import 'package:autiscope_app/core/resources/resources.dart';
import 'package:flutter/material.dart';

class TextCustomWidget extends StatelessWidget {
  const TextCustomWidget({
    super.key,
    required this.text,
    this.isTitle = false,
  });

  final String text;
  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
              color: AppColors.black,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.w500,
              fontSize: isTitle ? 22 : 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: isTitle ? 30 : 20,
        ),
      ],
    );
  }
}
