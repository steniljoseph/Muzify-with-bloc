part of 'switchstate_cubit.dart';

abstract class SwitchstateState extends Equatable {
  const SwitchstateState();

  @override
  List<Object> get props => [];
}

class SwitchstateInitial extends SwitchstateState {}

class SwitchChange extends SwitchstateState {
  final bool switchchange;

  const SwitchChange({required this.switchchange});
  @override
  List<Object> get props => [switchchange];
}
