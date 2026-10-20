import 'package:material_ui/material_ui.dart';
import 'package:ulin/core/constants/colors_theme.dart';

class DropdownCustom extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final double? height;
  final double? width;

  const DropdownCustom({
    super.key,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      height: height,
      width: width,
      child: DropdownButtonFormField<String>(
        dropdownColor: WarnaApp.wrWhite,
        isExpanded: true,
        hint: Text(
          hintText,
          style: TextStyle(
            fontSize: 14,
            color: WarnaApp.wrGrey.withValues(alpha: 0.6),
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
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
      ),
    );
  }
}
