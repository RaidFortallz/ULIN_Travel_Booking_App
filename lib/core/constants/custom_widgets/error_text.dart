import 'package:flutter/material.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class ErrorText extends StatelessWidget {
  final String text;

  const ErrorText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.error_outline_rounded, size: 14, color: WarnaApp.wrRed),
        SizedBox(width: 4),
        Expanded(child: TextCustom(text, fontSize: 11, color: WarnaApp.wrRed)),
      ],
    );
  }
}
