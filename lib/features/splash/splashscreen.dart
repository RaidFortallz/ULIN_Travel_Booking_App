import 'package:material_ui/material_ui.dart';
import 'package:ulin/core/constants/colors_theme.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WarnaApp.wrGreen,
      body: Center(
        child: Image.asset('assets/images/ulin.png', width: 140, height: 140),
      ),
    );
  }
}
