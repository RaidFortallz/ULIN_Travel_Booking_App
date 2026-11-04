import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/di/injection.dart';
import 'package:ulin/core/router/routes_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  await setupDependencies();

  final authBloc = getIt<AuthBloc>()..add(const AuthStarted());
  final router = RoutesApp.create(authBloc);

  runApp(MyApp(authBloc: authBloc, router: router));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  final GoRouter router;

  const MyApp({super.key, required this.authBloc, required this.router});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: authBloc,
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Poppins",
              scaffoldBackgroundColor: WarnaApp.wrBody,
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
