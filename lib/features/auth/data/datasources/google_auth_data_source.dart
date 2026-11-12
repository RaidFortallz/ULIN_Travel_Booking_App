import 'package:google_sign_in/google_sign_in.dart';
import 'package:ulin/core/config/app_config.dart';
import 'package:ulin/core/error/failure.dart';

class GoogleAuthDataSource {
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    final serverClientId = AppConfig.googleServerClientId;

    await GoogleSignIn.instance.initialize(
      serverClientId: serverClientId.isEmpty ? null : serverClientId,
    );

    _initialized = true;
  }

  Future<String?> getIdToken() async {
    await _ensureInitialized();

    try {
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;

      if (idToken == null) {
        throw const Failure(
          'Google did not return an ID token. Check the Google client configuration.',
        );
      }

      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      throw const Failure('Google sign-in failed. Please try again.');
    }
  }

  Future<void> signOut() async {
    if (!_initialized) return;

    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
  }
}
