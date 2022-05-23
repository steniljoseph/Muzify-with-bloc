import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../database/dbsongs.dart';
part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBlocBloc() : super(const SearchBlocInitial(fullSongs: [])) {
    on<SerachInputEvent>((event, emit) {
      final box = MusicBox.getInstance();
      List<LocalSongs> dbSongs = [];
      List<Audio> allSongs = [];
      dbSongs = box.get("musics") as List<LocalSongs>;
      for (var element in dbSongs) {
        allSongs.add(
          Audio.file(
            element.uri.toString(),
            metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist,
            ),
          ),
        );
      }
      List<Audio> searchTitle = allSongs.where((element) {
        return element.metas.title!.toLowerCase().startsWith(
              event.search.toLowerCase(),
            );
      }).toList();

      List<Audio> searchArtist = allSongs.where((element) {
        return element.metas.artist!.toLowerCase().startsWith(
              event.search.toLowerCase(),
            );
      }).toList();

      List<Audio> searchResult = allSongs;
      if (searchTitle.isNotEmpty) {
        searchResult = searchTitle;
      } else {
        searchResult = searchArtist;
      }

      emit(SearchBlocInitial(fullSongs: searchResult));
    });
  }
}
