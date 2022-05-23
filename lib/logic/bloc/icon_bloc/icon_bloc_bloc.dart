import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'icon_bloc_event.dart';
part 'icon_bloc_state.dart';

class IconBlocBloc extends Bloc<IconBlocEvent, IconBlocState> {
  IconBlocBloc() : super(IconBlocInitial()) {
    on<IconChangeEvent>((event, emit) {
      emit(IconChangeState(iconData: event.iconData));
      emit(const IconChangedState());
    });
    on<IconChangedEvent>((event, emit) {
      emit(const IconChangedState());
      emit(const IconChangedState());
    });
  }
}
