import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:libello/features/shared/data/repositories/auth.dart';
import 'package:libello/features/shared/data/repositories/notes.dart';
import 'package:libello/features/shared/domain/repositories/auth.dart';
import 'package:libello/features/shared/domain/repositories/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  /// shared preferences
  getIt.registerFactoryAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  /// firebase
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  /// google sign in
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  /// repositories
  getIt.registerSingleton<BaseAuthRepository>(AuthRepository());
  getIt.registerSingleton<BaseNoteRepository>(NoteRepository());
}
