import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jikan_api2/Providers/provider_favorite.dart';
import 'package:jikan_api2/features/anime_list/widgets/anime_tile.dart';
import 'package:jikan_api2/features/fullAnimeList/bloc/full_anime_list_bloc.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/models/animeCategory.dart';
import 'package:provider/provider.dart'; 
class FullAnimeListScreen extends StatefulWidget {
  const FullAnimeListScreen({super.key, required this.animeRepository, required this.listType, required this.title});
  final AbstractAnimeRepository animeRepository; 
  final AnimeListType listType; 
  final String title;

  @override
  State<FullAnimeListScreen> createState() => _FullAnimeListScreenState();
}
class _FullAnimeListScreenState extends State<FullAnimeListScreen> {
  
  @override
  void initState() {
    super.initState();
    context.read<FullAnimeListBloc>().add(LoadFullAnimeList(widget.animeRepository, widget.listType));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        leading: IconButton(onPressed: () { Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back)),
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 10),
        child: BlocBuilder<FullAnimeListBloc, FullAnimeListState>(
          builder: (context, state) {
            if (state is FullAnimeListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FullAnimeListLoaded) {
              final animeList = state.anime;
              return Consumer<FavoriteProvider>( 
                builder: (context, favoriteProvider, child) {
                  return Center(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2), 
                      itemCount: animeList.length,
                      itemBuilder: (context, index) {
                        final anime = animeList[index];
                        return AnimeTile(anime: anime);
                      },
                    ),
                  );
                },
              );
            } else if (state is FullAnimeListLoadedFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Something went wrong'),
                    const Text('Please try again later'),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        context.read<FullAnimeListBloc>().add(LoadFullAnimeList(widget.animeRepository, widget.listType));
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No anime found.'));
          },
        ),
      ),
    );
  }
}
