import 'package:flutter/material.dart';
import 'package:jikan_api2/repositories/models/anime.dart';

class FavoriteProvider with ChangeNotifier{
  final Set<Anime> _favorites = {};
  List<Anime> get favorites => _favorites.toList();
  void addFavorite(Anime anime) {
    _favorites.add(anime);
    notifyListeners();
  }
  void removeFavorite(Anime anime) {
    _favorites.removeWhere((item) => item.id == anime.id);
    notifyListeners();
  }
  bool isFavorite(int animeId) {
    return favorites.any((anime) => anime.id == animeId);
  }
  
}