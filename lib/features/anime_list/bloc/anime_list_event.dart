part of 'anime_list_bloc.dart';

abstract class AnimeListEvent extends Equatable{}

class LoadAnimeList extends AnimeListEvent{
  LoadAnimeList({this.completer});

  final Completer? completer;
  
  @override
  List<Object?> get props => [completer];

  

}