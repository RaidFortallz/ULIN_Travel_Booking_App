import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:material_ui/material_ui.dart';

void showAppSnackBar(BuildContext context, String message) {
  final snackbar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 3),
    content: AwesomeSnackbarContent(
      title: "Something Went Wrong",
      message: message,
      contentType: ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}

Future<void> showAppSuccessSnackbar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 2),
}) async {
  final screenHeight = MediaQuery.sizeOf(context).height;

  final snackbar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    duration: duration,
    margin: EdgeInsets.only(left: 16, right: 16, bottom: screenHeight / 2 - 45),
    content: AwesomeSnackbarContent(
      title: 'Success!',
      message: message,
      contentType: ContentType.success,
    ),
  );

  final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
  await messenger.showSnackBar(snackbar).closed;
}
