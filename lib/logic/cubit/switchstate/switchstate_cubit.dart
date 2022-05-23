import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'switchstate_state.dart';

class SwitchstateCubit extends Cubit<SwitchstateState> {
  SwitchstateCubit() : super(SwitchstateInitial());
  bool changeSwitch(bool switchy) {
    emit(SwitchChange(switchchange: switchy));
    return switchy;
  }
}
