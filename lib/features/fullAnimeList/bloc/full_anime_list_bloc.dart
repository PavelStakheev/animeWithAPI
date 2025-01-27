import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/models/anime.dart';
import 'package:jikan_api2/repositories/models/animeCategory.dart';
import 'package:talker_flutter/talker_flutter.dart';


part 'full_anime_list_event.dart';
part 'full_anime_list_state.dart';


class FullAnimeListBloc extends Bloc<FullAnimeListEvent, FullAnimeListState> {
  FullAnimeListBloc(this.animeRepository) : super(FullAnimeListInitial()) {
    on<LoadFullAnimeList>(_load);
  
  }
    final AbstractAnimeRepository  animeRepository;

    void _load(
      LoadFullAnimeList event, 
      Emitter emit
      ) async {
        emit(FullAnimeListLoading()); 
        try {
        List<Anime> animeList;
        switch (event.listType) {
          case AnimeListType.animeOf2005:
            animeList = await event.animeRepository.getAnimeList2005();
            break;
          case AnimeListType.topAnime:
            animeList = await event.animeRepository.getAnimeListTopAnime();
            break;
          case AnimeListType.animeOf2010:
            animeList = await event.animeRepository.getAnimeList2010(); 
            break;
          default:
            throw Exception('Unknown anime list type');
        }
        emit(FullAnimeListLoaded(anime: animeList));
        } catch (e, st) {
          emit(FullAnimeListLoadedFailure(e));
          GetIt.I<Talker>().handle(e, st);
        }
}
}