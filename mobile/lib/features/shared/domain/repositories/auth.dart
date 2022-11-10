import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Future<Either<User, String>> login();

  Future<void> logout();

  String? get displayName;

  Stream<bool> get loginStatus;
}
