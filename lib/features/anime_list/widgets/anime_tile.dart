import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api2/Providers/provider_favorite.dart';
import 'package:jikan_api2/features/anime_detail/view/anime_detail_screen.dart';
import 'package:jikan_api2/repositories/models/anime.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';


class AnimeTile extends StatefulWidget {
  const AnimeTile({super.key, required this.anime});
  final Anime anime;

  @override
  State<AnimeTile> createState() => _AnimeTileState();
}

class _AnimeTileState extends State<AnimeTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        final isFavorite = favoriteProvider.isFavorite(widget.anime.id);
        final animeDetails = widget.anime.details;
        //  if (isFavorite) {
        //   GetIt.I<Talker>().info('Аниме в избранном: ${widget.anime.id}');
        // } else {
        //   GetIt.I<Talker>().info('Аниме не в избранном: ${widget.anime.id}');
        // }
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimeDetailScreen(anime: widget.anime)));
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      height: 300,
                      width: 200,
                      animeDetails.imageUrl!,
                     
                                    fit: BoxFit.cover,
                                    )
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    )),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                       try {
                      if (isFavorite) {
                        favoriteProvider.removeFavorite(widget.anime);
                        //GetIt.I<Talker>().info('Убрано из избранного: ${widget.anime.id}');
                      } else {
                        favoriteProvider.addFavorite(widget.anime);
                        //GetIt.I<Talker>().info('Добавлено в избранное: ${widget.anime.id}');
                      }
                      //final updatedIsFavorite = favoriteProvider.isFavorite(widget.anime.id);
                      //GetIt.I<Talker>().info('Текущее состояние: ${updatedIsFavorite ? "в избранном" : "не в избранном"}');
                    } catch (e, st) {
                      GetIt.I<Talker>().handle(e, st);
                    }
              
                    });
                   
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 22,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
