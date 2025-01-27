import 'package:dio/dio.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/models/anime.dart';
import 'package:jikan_api2/repositories/models/anime_detail.dart';
import 'package:jikan_api2/repositories/models/genre.dart';

class AnimeRepository implements AbstractAnimeRepository {
AnimeRepository({
required this.dio});

final Dio dio;

Future<void> _delay() async {
  await Future.delayed(const Duration(seconds: 1)); // Задержка 1 секунда
}

@override
Future<List<Anime>> getAnimeList2005() async{
await _delay();
final response = await dio.get('https://api.jikan.moe/v4/seasons/2005/summer?sfw');
return _fetchAnimeWithApi(response);
}

@override
Future<List<Anime>> getAnimeListTopAnime() async{
  await _delay();
final response = await dio.get('https://api.jikan.moe/v4/top/anime');
return _fetchAnimeWithApi(response);
}

@override
Future<List<Anime>> getAnimeList2010() async{
  await _delay();
final response = await dio.get('https://api.jikan.moe/v4/seasons/2010/spring?sfw');
return _fetchAnimeWithApi(response);
}

@override
Future<Anime> getAnimeDetail(int currencyCode) async{
  await _delay();
final response = await dio.get('https://api.jikan.moe/v4/anime/$currencyCode');
final data = response.data as Map<String, dynamic>;
final data1 = data['data'] as Map<String, dynamic>;
final details = AnimeDetail.fromJson(data1);
return Anime(id: currencyCode, details: details);
}

@override
Future<List<Anime>> getAnimeListBySeason(int year, String season) async {
  await _delay();
final response = await dio.get('https://api.jikan.moe/v4/seasons/$year/$season');
return _fetchAnimeWithApi(response);
}

@override
  Future<List<Genre>> getGenres() async {
  await _delay();
    final response = await dio.get('https://api.jikan.moe/v4/genres/anime');
    final data = response.data as Map<String, dynamic>;
    final genresData = data['data'] as List<dynamic>;

    return genresData.map((e) {
      final genreData = e as Map<String, dynamic>;
      return Genre.fromJson(genreData);
    }).toList();
  }

  // Новый метод для получения аниме по жанру
  @override
  Future<List<Anime>> getAnimeByGenre(int genreId) async {
    await _delay();
    final response = await dio.get('https://api.jikan.moe/v4/anime?genres=$genreId');
    return _fetchAnimeWithApi(response);
  }

List<Anime> _fetchAnimeWithApi(Response<dynamic> response) {
final data = response.data as Map<String, dynamic>;
final data1 = data['data'] as List<dynamic>;

final animeList = data1.map((e){
 final animeData = e as Map<String, dynamic>; 
 final details = AnimeDetail.fromJson(animeData);

 return Anime(
   id: e['mal_id'], 
   details: details);
}
).toList();
return animeList;
}

}