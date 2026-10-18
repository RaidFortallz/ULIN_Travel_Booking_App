import 'package:go_router/go_router.dart';
import 'package:ulin/features/auth/presentation/email_verification_page.dart';
import 'package:ulin/features/auth/presentation/login_page.dart';
import 'package:ulin/features/auth/presentation/onboarding.dart';
import 'package:ulin/features/auth/presentation/register_page.dart';
import 'package:ulin/features/home/presentation/pages/home_page.dart';
import 'package:ulin/features/profile/presentation/profile_setup_step1_page.dart';
import 'package:ulin/features/profile/presentation/profile_setup_step2_page.dart';
import 'package:ulin/features/splash/splashscreen.dart';

class RoutesApp {
  static final GoRouter appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const Splashscreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const Onboarding(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/profile1',
        name: 'profile1',
        builder: (context, state) => const ProfileSetupStep1Page(),
      ),
      GoRoute(
        path: '/profile2',
        name: 'profile2',
        builder: (context, state) => const ProfileSetupStep2Page(),
      ),
      GoRoute(
        path: '/emailverification',
        name: 'emailverification',
        builder: (context, state) => const EmailVerificationPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
