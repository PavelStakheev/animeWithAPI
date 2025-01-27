import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/models/anime.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'anime_detail_event.dart';
part 'anime_detail_state.dart';


class AnimeDetailBloc extends Bloc<AnimeDetailEvent, AnimeDetailState> {
  AnimeDetailBloc(this.animeRepository) : super(const AnimeDetailState()) {
    on<LoadAnimeDetail>(_load);
  }
final AbstractAnimeRepository animeRepository;
  Future<void> _load(
    LoadAnimeDetail event,
    Emitter <AnimeDetailState> emit
  ) async{
    try {
  if ( state is! AnimeDetailLoaded){
    emit(AnimeDetailLoading());
  }
  
  final animeDetails = await animeRepository.getAnimeDetail(event.currencyCode);
  emit(AnimeDetailLoaded(animeDetails));
      }  catch (e,st) {
          emit(AnimeDetailLoadingFailure(e));
          GetIt.I<Talker>().handle(e,st);
      }
  }
 @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}