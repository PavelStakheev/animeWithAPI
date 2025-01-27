part of 'explorer_bloc.dart';

abstract class ExplorerEvent extends Equatable{
const ExplorerEvent();

  @override
  List<Object?> get props => [];

}

class LoadExplorerEvent extends ExplorerEvent{

  final int year;
  final String season;
 

  const LoadExplorerEvent( {required this.year, required this.season});
 @override
  List<Object?> get props => [year, season];
}

class LoadGenresEvent extends ExplorerEvent {
  const LoadGenresEvent();
}

class FilterAnimeByGenreEvent extends ExplorerEvent {
  final Genre selectedGenre;

  const FilterAnimeByGenreEvent(this.selectedGenre);

  @override
  List<Object> get props => [selectedGenre];
}
