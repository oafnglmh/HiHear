import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hihear_mo/domain/repositories/auth_repository.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState.initial()) {
    on<_LoginWithFacebook>(_onLoginWithFacebook);
    on<_LoginWithGoogle>(_onLoginWithGoogle);
  }
  Future<void> _onLoginWithGoogle(_LoginWithGoogle event, Emitter<AuthState> emit)async{
    emit(const AuthState.loading());
    try{
      final result = await _repository.loginWithGoogle();
      result.fold((failure) => emit(AuthState.error(failure.message)), (user)=> emit(AuthState.authenticated(user)),);
    }
    catch (e, s) {
      emit(AuthState.error('Login with Google failed: $e'));
      addError(e, s);
    }
  }
  Future<void> _onLoginWithFacebook(_LoginWithFacebook event, Emitter<AuthState> emit)async{
    emit(const AuthState.loading());
    try{
      final result = await _repository.loginWithGoogle();
      result.fold((failure) => emit(AuthState.error(failure.message)), (user)=> emit(AuthState.authenticated(user)),);
    }
    catch (e, s) {
      emit(AuthState.error('Login with Google failed: $e'));
      addError(e, s);
    }
  }
}
