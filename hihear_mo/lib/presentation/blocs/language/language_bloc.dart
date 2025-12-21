import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hihear_mo/core/enums/language_type.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(const Locale('en'))) {
    on<ChangeLanguageEvent>((event, emit) {
      emit(LanguageState(Locale(event.language.code)));
    });
  }
}
