import 'package:jikan_api2/repositories/models/anime.dart';
import 'package:jikan_api2/repositories/models/genre.dart';


abstract class AbstractAnimeRepository{
  Future<List<Anime>> getAnimeList2005(); 
  Future<List<Anime>> getAnimeListTopAnime();
  Future<List<Anime>> getAnimeList2010();
  Future<Anime> getAnimeDetail(int currencyCode);
  Future<List<Anime>> getAnimeListBySeason(int year, String season);
  Future<List<Genre>> getGenres();
  Future<List<Anime>> getAnimeByGenre(int genreId);
}
