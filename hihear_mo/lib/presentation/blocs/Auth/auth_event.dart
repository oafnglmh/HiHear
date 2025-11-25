part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.loginWithGoogle() = _LoginWithGoogle;
  const factory AuthEvent.loginWithFacebook() = _LoginWithFacebook;
  const factory AuthEvent.logout() = _Logout;
  const factory AuthEvent.loadUser() = _LoadUser;
  const factory AuthEvent.updateLevel(String level) = _UpdateLevel;

}
