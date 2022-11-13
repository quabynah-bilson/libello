import 'package:bloc/bloc.dart';
import 'package:libello/core/injector.dart';
import 'package:libello/features/shared/domain/repositories/auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _repo = getIt.get<BaseAuthRepository>();

  AuthCubit() : super(AuthInitial());

  Future<void> login() async {
    emit(AuthLoading());
    var either = await _repo.login();
    either.fold(
      (l) => emit(AuthSuccess(l)),
      (r) => emit(AuthError(r)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await _repo.logout();
    emit(const AuthSuccess('Signed out successfully'));
  }

  Stream<bool> get loginStatus => _repo.loginStatus;

  Future<String?> get displayName => _repo.displayName;

  Future<String?> get emailAddress => _repo.emailAddress;
}
