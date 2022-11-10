import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/injector.dart';
import 'package:libello/features/shared/domain/repositories/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// implementation of [BaseAuthRepository]
class AuthRepository implements BaseAuthRepository {
  @override
  String? get displayName =>
      getIt.get<SharedPreferences>().getString(kUsernameKey);

  @override
  Future<Either<User, String>> login() async {
    try {
      var account = await getIt.get<GoogleSignIn>().signIn();
      if (account != null) {
        var authentication = await account.authentication;
        var credential = GoogleAuthProvider.credential(
            idToken: authentication.idToken,
            accessToken: authentication.accessToken);
        var userCredential =
            await getIt.get<FirebaseAuth>().signInWithCredential(credential);
        if (userCredential.user != null) {
          /// save credentials locally
          var prefs = await getIt.getAsync<SharedPreferences>();
          await prefs.setString(kUserIdKey, userCredential.user!.uid);
          await prefs.setString(kUsernameKey,
              userCredential.user!.displayName ?? 'Cherished user');
          return Left(userCredential.user!);
        }
      }
    } catch (e) {
      logger.e(e);
    }
    return const Right('Unable to complete authentication. Please try again');
  }

  @override
  Future<void> logout() async => await getIt.get<SharedPreferences>().clear();

  @override
  Stream<bool> get loginStatus => getIt
      .get<FirebaseAuth>()
      .authStateChanges()
      .map((event) => event != null);
}
