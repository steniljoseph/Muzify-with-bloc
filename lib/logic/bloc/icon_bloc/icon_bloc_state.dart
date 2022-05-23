part of 'icon_bloc_bloc.dart';

abstract class IconBlocState extends Equatable {
  const IconBlocState();
}

class IconBlocInitial extends IconBlocState {
  @override
  List<Object?> get props => [];
}

class IconChangeState extends IconBlocState {
  final IconData iconData;

  const IconChangeState({required this.iconData});

  @override
  List<Object?> get props => [iconData];
}

class IconChangedState extends IconBlocState {
  

  const IconChangedState();

  @override
  List<Object?> get props => [];
}
