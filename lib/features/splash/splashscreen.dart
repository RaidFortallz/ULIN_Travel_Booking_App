import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ulin/core/constants/colors_theme.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    context.go('/onboarding');
  }

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
