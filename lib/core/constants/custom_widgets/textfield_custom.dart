import 'package:material_ui/material_ui.dart';
import 'package:ulin/core/constants/colors_theme.dart';

class TextfieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final double? height;
  final double? width;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final int maxLines;
  final VoidCallback? onTap;

  final bool isPassword;
  final bool isObscure;
  final VoidCallback? onToggle;

  const TextfieldCustom({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.height,
    this.width,
    this.prefix,
    this.suffix,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.isPassword = false,
    this.isObscure = true,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width, child: _buildTextField());
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: isPassword ? isObscure : false,
      autocorrect: false,
      autofocus: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: WarnaApp.wrGrey.withValues(alpha: 0.6),
        ),

        contentPadding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: maxLines > 1 ? 12 : 0,
        ),
        prefixIcon: prefix,
        suffixIcon: _buildSuffix(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: WarnaApp.wrGreen, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: WarnaApp.wrGreen, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: WarnaApp.wrGreen, width: 1),
        ),
      ),
    );
  }

  Widget? _buildSuffix() {
    if (!isPassword && suffix == null) return null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ?suffix,
        if (isPassword)
          IconButton(
            onPressed: onToggle,
            icon: Icon(
              isObscure
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
            ),
          ),
      ],
    );
  }
}
