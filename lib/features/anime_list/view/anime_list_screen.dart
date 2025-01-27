import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jikan_api2/Providers/provider_favorite.dart';
import 'package:jikan_api2/features/anime_list/bloc/anime_list_bloc.dart';
import 'package:jikan_api2/features/anime_list/widgets/anime_tile.dart';
import 'package:jikan_api2/features/fullAnimeList/view/full_anime_list_screen.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/models/animeCategory.dart';
import 'package:provider/provider.dart';



class AnimeListScreen extends StatefulWidget {
  const AnimeListScreen({super.key});

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}




class _AnimeListScreenState extends State<AnimeListScreen> {
 
  @override
  Widget build(BuildContext context) {
     final animelistbloc = BlocProvider.of<AnimeListBloc>(context);
     final animeRepository = Provider.of<AbstractAnimeRepository>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: const Center(child: Text('JIKAN Anime')),
      ),
      body: BlocBuilder<AnimeListBloc, AnimeListState>(
          builder: (context, state) {
          if (state is AnimeListLoaded){
            return SingleChildScrollView(
              child: Column(
                children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 12, top: 5),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const Text('Anime of 2005'),
                         TextButton(
                          onPressed: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullAnimeListScreen(animeRepository: animeRepository, listType: AnimeListType.animeOf2005, title: 'Anime of 2005',)
                              ),
                            );
                          }, 
                          child: const Text('View all'))
                      ],
                                         ),
                   ),
                   SizedBox(
                    height: 250,
                    child: Consumer<FavoriteProvider>( 
                      builder: (context, favoriteProvider, child) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.anime.length < 5 ? state.anime.length : 5,
                          itemBuilder: (context, index) {
                            final anime = state.anime[index];
                            return AnimeTile(anime: anime);
                          },
                        );
                      },
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.only(left: 12, top: 5),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const Text('Top anime'),
                         TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullAnimeListScreen(animeRepository: animeRepository, listType: AnimeListType.topAnime, title: 'Top animes',)
                              ),
                            );},
                          child: const Text('View all'),
                        )
                      ],
                    ),
                   ),
                    SizedBox(
                    height: 250,
                    child: Consumer<FavoriteProvider>( 
                      builder: (context, favoriteProvider, child) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.anime1.length < 5 ? state.anime1.length : 5,
                          itemBuilder: (context, index) {
                            final anime = state.anime1[index];
                            return AnimeTile(anime: anime);
                          },
                        );
                      },
                    ),
                  ),
                    Padding(
                     padding: const EdgeInsets.only(left: 12, top: 5),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const Text('Anime of 2010'),
                         TextButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullAnimeListScreen(animeRepository: animeRepository, listType: AnimeListType.animeOf2010, title: 'Anime of 2010',)
                              ),
                            );
                         }, child: const Text('View all'))
                      ],
                                         ),
                   ),
                    SizedBox(
                    height: 250,
                    child: Consumer<FavoriteProvider>( 
                      builder: (context, favoriteProvider, child) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.anime2.length < 5 ? state.anime2.length : 5,
                          itemBuilder: (context, index) {
                            final anime = state.anime2[index];
                            return AnimeTile(anime: anime);
                          },
                        );
                      },
                    ),
                  ),
                   
                   
                ],
              ),
            );
          }
          if (state is AnimeListLoadingFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Something went wrong',
                   
                  ),
                  const Text(
                    'Please try againg later',
                    
                  ),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      animelistbloc.add(LoadAnimeList());
                    },
                    child: const Text('Try againg'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
        
        ),
     
    );
  }
}