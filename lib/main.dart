import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api2/list_app.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/anime_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация Talker
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);

  // Инициализация Dio и регистрация репозитория
  final dio = Dio();
  GetIt.I.registerLazySingleton<AbstractAnimeRepository>(() => AnimeRepository(dio: dio));

  // Запуск приложения
  runApp(const MyApp());
}