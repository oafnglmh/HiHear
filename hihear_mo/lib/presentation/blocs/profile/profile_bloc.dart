import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdateAvatar>(_onUpdateAvatar);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    emit(
      state.copyWith(name: "Lê Minh Hoàng", email: "hcassano.dev@gmail.com"),
    );
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isSaving: true));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(name: event.name, email: event.email, isSaving: false));
  }

  void _onUpdateAvatar(UpdateAvatar event, Emitter<ProfileState> emit) {
    emit(state.copyWith(avatar: event.image));
  }
}
