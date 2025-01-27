import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/models/anime.dart';
import 'package:jikan_api2/repositories/models/genre.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'explorer_event.dart';
part 'explorer_state.dart';


class ExplorerBloc extends Bloc<ExplorerEvent, ExplorerState> {
  ExplorerBloc(this.animeRepository) : super(ExplorerStateInitial()) {
    on<LoadExplorerEvent>(_load);
    on<LoadGenresEvent>(_loadGenres);
    on<FilterAnimeByGenreEvent>(_filterAnimeByGenre);

    
  }
  final AbstractAnimeRepository  animeRepository;
  List<Anime> _allAnime = [];
  void _load(
    LoadExplorerEvent event,
    Emitter<ExplorerState> emit
  ) async{
    emit(ExplorerStateLoading());
    
   try {
      final response = await animeRepository.getAnimeListBySeason(event.year, event.season);
      _allAnime = response; 
      emit(ExplorerStateLoaded(anime: response));
    } catch (e, st) {
      emit(ExplorerStateLoadingFailure(e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  void _loadGenres(
    
    LoadGenresEvent event,
    Emitter<ExplorerState> emit
  ) async{
    emit(ExplorerStateLoading());
    
   try {
      final genres = await animeRepository.getGenres();
      
      emit(ExplorerStateGenresLoaded(genres));
    } catch (e, st) {
      emit(ExplorerStateLoadingFailure(e));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  void _filterAnimeByGenre(
    FilterAnimeByGenreEvent event,
    Emitter<ExplorerState> emit,
  ) {
    final selectedGenre = event.selectedGenre;
    final filteredAnime = _allAnime.where((anime) {
      return anime.details.genres.any((genre) => genre.name == selectedGenre.name);
    }).toList();

    emit(ExplorerStateLoaded(anime: filteredAnime)); // Эмитим отфильтрованный список
  }
  
}