import 'package:go_router/go_router.dart';
import 'package:ulin/core/router/go_router_refresh_stream.dart';
import 'package:ulin/features/auth/presentation/pages/email_verification_page.dart';
import 'package:ulin/features/auth/presentation/pages/login_page.dart';
import 'package:ulin/features/auth/presentation/pages/onboarding.dart';
import 'package:ulin/features/auth/presentation/pages/register_page.dart';
import 'package:ulin/features/main/pages/main_page.dart';
import 'package:ulin/features/profile/presentation/pages/profile_setup_step1_page.dart';
import 'package:ulin/features/profile/presentation/pages/profile_setup_step2_page.dart';
import 'package:ulin/features/splash/splashscreen.dart';

class RoutesApp {
  const RoutesApp._();

  static const Set<String> _publicRoutes = {
    '/onboarding',
    '/login',
    '/register',
    '/forgot-password',
    '/reset-password',
  };

  static const Set<String> _setupFlow = {
    '/profile1',
    '/profile2',
    '/emailverification',
  };

  static GoRouter create(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: (context, state) {
        final auth = authBloc.state;
        final location = state.uri.path;
        final isPublic = _publicRoutes.contains(location);

        if (auth.status == AuthStatus.unknown) {
          return location == '/' ? null : '/';
        }

        if (auth.status == AuthStatus.unauthenticated) {
          if (isPublic) return null;
          return location == '/' ? '/onboarding' : '/login';
        }

        final user = auth.user!;

        if (!user.profileCompleted) {
          return location == '/profile1' ? null : '/profile1';
        }

        if (!user.emailVerified) {
          return _setupFlow.contains(location) ? null : '/emailverification';
        }

        if (location == '/' || location == '/emailverification' || isPublic) {
          return '/home';
        }

        return null;
      },

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
          path: '/forgot-password',
          name: 'forgot-password',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: '/reset-password',
          name: 'reset-password',
          builder: (context, state) => ResetPasswordPage(
            email: state.uri.queryParameters['email'] ?? '',
          ),
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
          builder: (context, state) => const MainPage(),
        ),
      ],
    );
  }
}
