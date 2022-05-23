part of 'bottomnav_cubit.dart';

@immutable
abstract class BottomnavState {}

class BottomnavInitial extends BottomnavState {}

class BottomIndex extends BottomnavState {
  final int newIndex;

  BottomIndex({required this.newIndex});
}

