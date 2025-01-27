import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api2/Profile/nav_bar_screen.dart';
import 'package:jikan_api2/Providers/provider_favorite.dart';
import 'package:jikan_api2/features/Explorer/bloc/explorer_bloc.dart';
import 'package:jikan_api2/features/anime_list/bloc/anime_list_bloc.dart';
import 'package:jikan_api2/features/fullAnimeList/bloc/full_anime_list_bloc.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/theme/theme.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FavoriteProvider()),
          Provider<AbstractAnimeRepository>(create: (_) => GetIt.I<AbstractAnimeRepository>()),
          BlocProvider<AnimeListBloc>(create: (context) => AnimeListBloc(GetIt.I<AbstractAnimeRepository>())..add(LoadAnimeList())),
          BlocProvider<FullAnimeListBloc>(create: (context) => FullAnimeListBloc(GetIt.I<AbstractAnimeRepository>())),
          BlocProvider<ExplorerBloc>(create: (context) => ExplorerBloc(GetIt.I<AbstractAnimeRepository>())),
        ] ,
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: const MyNavBarScreen(),
      ));
      
    
  }
}