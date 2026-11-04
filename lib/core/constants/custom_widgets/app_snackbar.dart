import 'package:material_ui/material_ui.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';

void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: TextCustom(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
}
