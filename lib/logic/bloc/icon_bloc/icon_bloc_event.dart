part of 'icon_bloc_bloc.dart';

abstract class IconBlocEvent extends Equatable {
  const IconBlocEvent();
}

class IconChangeEvent extends IconBlocEvent {
  final IconData iconData;
  const IconChangeEvent({required this.iconData});
  @override
  List<Object?> get props => [iconData];
}

class IconChangedEvent extends IconBlocEvent {
  const IconChangedEvent();
  @override
  List<Object?> get props => [];
}
