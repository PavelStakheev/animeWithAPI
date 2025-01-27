import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/models/anime.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'anime_list_event.dart';
part 'anime_list_state.dart';


class AnimeListBloc extends Bloc<AnimeListEvent, AnimeListState> {
  AnimeListBloc(this.animeRepository) : super(AnimeListInitial()) {
    on<LoadAnimeList>(_load);
  }
  final AbstractAnimeRepository  animeRepository;

    Future<void> _load(LoadAnimeList event, Emitter<AnimeListState> emit) async {
        try {
          if (state is! AnimeListLoaded){
            emit(AnimeListLoading());
          }
          final animeList2005 = await animeRepository.getAnimeList2005();
          final animeListTop = await animeRepository.getAnimeListTopAnime();
          final animeList2010 = await animeRepository.getAnimeList2010();
          emit(AnimeListLoaded(
            anime: animeList2005, 
            anime1: animeListTop,
            anime2: animeList2010
            
           ));
          
        } catch (e,st) {
          emit(AnimeListLoadingFailure(exception: e));
          GetIt.I<Talker>().handle(e,st);
        } finally{
          event.completer?.complete();
        }
    }
}