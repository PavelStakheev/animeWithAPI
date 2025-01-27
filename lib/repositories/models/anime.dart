import 'package:jikan_api2/repositories/models/anime_detail.dart';

class Anime {
 Anime({
  required this.id,
  required this.details,
  this.isFavorite = false

  });


  final int id;
  final AnimeDetail details;
  bool isFavorite;
  

 }