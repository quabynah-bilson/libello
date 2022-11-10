part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess<T> extends AuthState {
  final T data;

  const AuthSuccess(this.data);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
