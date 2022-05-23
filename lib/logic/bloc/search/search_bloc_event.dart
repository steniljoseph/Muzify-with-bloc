part of 'search_bloc_bloc.dart';

abstract class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();
  @override
  List<Object> get props => [];
}

class SerachInputEvent extends SearchBlocEvent {
  final String search;

  const SerachInputEvent({required this.search});
  @override
  List<Object> get props => [search];
}
