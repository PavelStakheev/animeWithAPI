import 'package:flutter/material.dart';
import 'package:jikan_api2/Providers/provider_favorite.dart';
import 'package:jikan_api2/features/anime_detail/view/anime_detail_screen.dart';
import 'package:jikan_api2/theme/theme.dart';
import 'package:provider/provider.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    final finalList = provider.favorites;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: finalList.isEmpty ? 
        Center(
              child: Text(
                "Список избранных пуст",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
              ),
            ) : 
        Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: finalList.length,
                  itemBuilder: (context, index) {
                    final favoriteItem = finalList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder:(context) => AnimeDetailScreen(anime: favoriteItem )));
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade800,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 85,
                                    height: 85,
                                    decoration: BoxDecoration(
                                      color: darkTheme.cardColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(favoriteItem.details.imageUrl!, 
                                    fit: BoxFit.cover,
                                    )
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 260,
                                        child: Text(
                                          favoriteItem.details.title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        favoriteItem.details.realise.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade400,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "\#Ranking ${favoriteItem.details.rank}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          // for delete button
                          Positioned(
                            top: 50,right: 35,
                            child: GestureDetector(
                              onTap: () {
                              provider.removeFavorite(favoriteItem);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}