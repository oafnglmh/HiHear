import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String name;
  final String email;

  const UpdateProfile(this.name, this.email);

  @override
  List<Object?> get props => [name, email];
}

class UpdateAvatar extends ProfileEvent {
  final File image;

  const UpdateAvatar(this.image);

  @override
  List<Object?> get props => [image];
}
