import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

class ButtonCustom extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final double width;
  final double height;
  final double fontSize;

  const ButtonCustom({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.width = 156,
    this.height = 48,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: WarnaApp.wrGreen,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: WarnaApp.wrWhite,
                  ),
                )
              : TextCustom(
                  label,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: WarnaApp.wrWhite,
                ),
        ),
      ),
    );
  }
}
