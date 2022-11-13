import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Future<Either<User, String>> login();

  Future<void> logout();

  Future<String?> get displayName;

  Future<String?> get emailAddress;

  Stream<bool> get loginStatus;
}
