part of 'favourites_bloc.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}

class RemoveFav extends FavouritesEvent {
  @override
  List<Object?> get props => [];
}
