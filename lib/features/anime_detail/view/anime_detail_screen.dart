import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:jikan_api2/Providers/provider_favorite.dart';

import 'package:jikan_api2/features/anime_detail/bloc/anime_detail_bloc.dart';
import 'package:jikan_api2/repositories/abstract_repository_anime.dart';
import 'package:jikan_api2/repositories/models/anime.dart';
import 'package:jikan_api2/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AnimeDetailScreen extends StatefulWidget {
  const AnimeDetailScreen({super.key, required this.anime});

  final Anime anime;

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  final _animeDetailsBloc = AnimeDetailBloc(
    GetIt.I<AbstractAnimeRepository>(),
  );

  late WebViewController controller;

  @override
  void initState() {
    _animeDetailsBloc.add(LoadAnimeDetail(currencyCode: widget.anime.id));
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Обновление индикатора загрузки
            print('Loading: $progress%');
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            print('HTTP error: ${error.response}');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision
                  .prevent; // Блокировка перехода на YouTube
            }
            return NavigationDecision.navigate; // Разрешение перехода
          },
        ),
      );

    // Проверка на наличие URL перед загрузкой
    final trailerUrl = widget.anime.details.trailer?.url;
    if (trailerUrl != null && trailerUrl.isNotEmpty) {
      controller.loadRequest(Uri.parse(trailerUrl));
    } else {
      // Можно загрузить страницу с сообщением или оставить пустой
      controller
          .loadRequest(Uri.parse('about:blank')); // Загрузка пустой страницы
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider,state) {
        final isFavorite = favoriteProvider.isFavorite(widget.anime.id);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade800,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              GestureDetector(
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
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          body: BlocBuilder<AnimeDetailBloc, AnimeDetailState>(
            bloc: _animeDetailsBloc,
            builder: (context, state) {
              if (state is AnimeDetailLoaded) {
                final anime = state.anime;
                final animeDetails = anime.details;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                animeDetails.imageUrl!,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(height: 10),
                          if (animeDetails.airing == false)
                            Container(
                              decoration: BoxDecoration(
                                  color: darkTheme.scaffoldBackgroundColor,
                                  border:
                                      Border.all(color: darkTheme.dividerColor),
                                  borderRadius: BorderRadius.circular(25)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Finished Airing',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            )
                          else
                            (Container(
                              decoration: BoxDecoration(
                                  color: darkTheme.scaffoldBackgroundColor,
                                  border:
                                      Border.all(color: darkTheme.dividerColor),
                                  borderRadius: BorderRadius.circular(25)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Currently Airing',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            )),
                          const SizedBox(height: 10),
                          Text(
                              '${animeDetails.title!}  ${animeDetails.realise.toString()}'),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color:
                                            darkTheme.scaffoldBackgroundColor,
                                        border: Border.all(
                                            color: darkTheme.dividerColor),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star_border,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(animeDetails.score.toString())
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${animeDetails.members} Users',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade500,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    children: [
                                      Text(' ${animeDetails.rank}'),
                                      const Text('#Ranking'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            animeDetails.synopsis!,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: (animeDetails.genres.isNotEmpty)
                                    ? Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        children: [
                                          const Text(
                                            'Genres:',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 8),
                                          Wrap(
                                            spacing: 8.0,
                                            children: animeDetails.genres
                                                .map((genre) {
                                              return Chip(
                                                  label: Text(genre.name));
                                            }).toList(),
                                          ),
                                        ],
                                      )
                                    : const Text('No genres available'),
                              ),
                            ],
                          ),
                          if (animeDetails.trailer != null &&
                              animeDetails.trailer?.url != null &&
                              animeDetails.trailer!.url!.isNotEmpty)
                            Column(
                              children: [
                                const Text(
                                  'Trailer:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    height: 200,
                                    width: double.infinity,
                                    child:
                                        WebViewWidget(controller: controller),
                                  ),
                                ),
                              ],
                            )
                          else
                            const Text('No trailer'),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}
