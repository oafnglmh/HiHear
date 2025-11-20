import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hihear_mo/domain/entities/user/user_entity.dart';
import 'package:hihear_mo/domain/repositories/auth_repository.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState.initial()) {
    on<_LoginWithGoogle>(_onLoginWithGoogle);
    on<_LoginWithFacebook>(_onLoginWithFacebook);
    on<_Logout>(_onLogout);
    on<_LoadUser>(_onLoadUser);
  }

  Future<void> _onLoginWithGoogle(
      _LoginWithGoogle event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final result = await _repository.loginWithGoogle();
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (user) => emit(AuthState.authenticated(user)),
      );
    } catch (e, s) {
      emit(AuthState.error('Login with Google failed: $e'));
      addError(e, s);
    }
  }

  Future<void> _onLoginWithFacebook(
      _LoginWithFacebook event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final result = await _repository.loginWithFacebook();
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (user) => emit(AuthState.authenticated(user)),
      );
    } catch (e, s) {
      emit(AuthState.error('Login with Facebook failed: $e'));
      addError(e, s);
    }
  }

  Future<void> _onLogout(_Logout event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final result = await _repository.logout();
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (_) => emit(const AuthState.loggedOut()),
      );
    } catch (e, s) {
      emit(AuthState.error('Logout failed: $e'));
      addError(e, s);
    }
  }
  Future<void> _onLoadUser(_LoadUser event, Emitter<AuthState> emit) async {
    final fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser != null) {
      emit(AuthState.authenticated(
        UserEntity(
          id: fbUser.uid,
          name: fbUser.displayName ?? "",
          email: fbUser.email ?? "",
          photoUrl: fbUser.photoURL ?? "",
          national: "",
        ),
      ));
    } else {
      emit(const AuthState.loggedOut());
    }
  }
}
