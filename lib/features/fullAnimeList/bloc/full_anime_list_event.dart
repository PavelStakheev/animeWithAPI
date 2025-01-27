part of 'full_anime_list_bloc.dart';

 abstract class FullAnimeListEvent extends Equatable{}

class LoadFullAnimeList extends FullAnimeListEvent{
  LoadFullAnimeList(this.animeRepository, this.listType);
  
   final AbstractAnimeRepository animeRepository;
   final AnimeListType listType;
    @override
    List<Object?> get props => [animeRepository, listType];

  
}