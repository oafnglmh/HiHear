import 'dart:io';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String name;
  final String email;
  final File? avatar;
  final bool isSaving;

  const ProfileState({
    this.name = '',
    this.email = '',
    this.avatar,
    this.isSaving = false,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    File? avatar,
    bool? isSaving,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [name, email, avatar, isSaving];
}
