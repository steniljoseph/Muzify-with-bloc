import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music/database/dbsongs.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc()
      : super(FavouritesInitial(
            list: MusicBox.getInstance().get("favourites")!)) {
    on<RemoveFav>((event, emit) {
      emit(FavouritesInitial(list: MusicBox.getInstance().get("favourites")!));
      emit(FavChange(list: MusicBox.getInstance().get("favourites")!));
    });
  }
}
