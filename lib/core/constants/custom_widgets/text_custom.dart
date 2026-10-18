import 'package:material_ui/material_ui.dart';
import 'package:ulin/core/constants/colors_theme.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final double letterSpacing;
  final double height;

  const TextCustom(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = WarnaApp.wrBlack,
    this.textAlign = TextAlign.left,
    this.letterSpacing = 0,
    this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
