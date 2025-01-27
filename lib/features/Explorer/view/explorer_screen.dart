import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jikan_api2/features/Explorer/bloc/explorer_bloc.dart';
import 'package:jikan_api2/features/anime_list/widgets/anime_tile.dart';
import 'package:jikan_api2/repositories/models/genre.dart';

class MyExplorerScreen extends StatefulWidget {
  const MyExplorerScreen({super.key});

  @override
  State<MyExplorerScreen> createState() => _MyExplorerScreenState();
}

class _MyExplorerScreenState extends State<MyExplorerScreen> with AutomaticKeepAliveClientMixin<MyExplorerScreen> {
  int selectedYear = DateTime.now().year; 
  String selectedSeason = 'spring'; 
  String searchQuery = '';
  Genre? selectedGenre;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final explorerBloc = BlocProvider.of<ExplorerBloc>(context);
      explorerBloc.add(LoadExplorerEvent(year: selectedYear, season: selectedSeason));
      // explorerBloc.add(const LoadGenresEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final explorerBloc = BlocProvider.of<ExplorerBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(66, 141, 36, 36),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 10),
                  hintText: 'Поиск аниме...',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), // Уменьшены отступы
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     SizedBox(
                      width: 100,
                        child: DropdownButtonFormField<int>(
                        value: selectedYear,
                        isDense: true,
                        decoration: InputDecoration(
                          labelText: 'Год',
                          labelStyle: const TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        items: List.generate(30, (index) => DateTime.now().year - index)
                            .map((year) => DropdownMenuItem<int>(
                                  value: year,
                                  child: Text(year.toString(), style: const TextStyle(fontSize: 12, height: 1.2)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value!;
                          });
                          explorerBloc.add(LoadExplorerEvent(year: selectedYear, season: selectedSeason));
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 100,
                        child: DropdownButtonFormField<String>(
                        value: selectedSeason,
                        isDense: true,
                        decoration: InputDecoration(
                          labelText: 'Сезон',
                          labelStyle: const TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        items: ['spring', 'summer', 'fall', 'winter']
                            .map((season) => DropdownMenuItem<String>(
                                  value: season,
                                  child: Text(season.capitalize(), style: const TextStyle(fontSize: 12, height: 1.2)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSeason = value!;
                          });
                          explorerBloc.add(LoadExplorerEvent(year: selectedYear, season: selectedSeason));
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Expanded(
                    //     child: BlocBuilder<ExplorerBloc, ExplorerState>(
                    //     builder: (context, state) {
                    //       print('Current state: $state');
                    //       if (state is ExplorerStateGenresLoaded) {
                    //         if (state.genres.isEmpty) {
                    //           return const Center(child: Text('Нет доступных жанров.'));
                    //         }
                    //         return DropdownButtonFormField<Genre>(
                    //           value: selectedGenre,
                    //           isDense: true,
                    //           decoration: InputDecoration(
                    //             labelText: 'Жанр',
                    //             labelStyle: const TextStyle(fontSize: 12),
                    //             border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(4),
                    //             ),
                    //           ),
                    //           items: state.genres.map((genre) {
                    //             return DropdownMenuItem<Genre>(
                    //               value: genre,
                    //               child: Text(genre.name, style: const TextStyle(fontSize: 12)),
                    //             );
                    //           }).toList(),
                    //           onChanged: (value) {
                    //             setState(() {
                    //               selectedGenre = value;
                    //               print('Selected Genre: ${selectedGenre?.name}');
                    //             });
                    //             if (selectedGenre != null) {
                    //               explorerBloc.add(FilterAnimeByGenreEvent(selectedGenre!));
                    //             } else {
                    //               print('No genre selected.'); // Отладочное сообщение
                    //             }
                    //           },
                              
                    //         );
                            
                    //       }
                    //       return const SizedBox(); // Если состояние еще не загружено
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),

            ),
          ),
          Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: BlocBuilder<ExplorerBloc, ExplorerState>(
              builder: (context, state) {
                if (state is ExplorerStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ExplorerStateLoaded) {
                  final animeList = state.anime.where((anime) {
                  final matchesSearchQuery = anime.details.title?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
                  // final matchesGenre = selectedGenre == null || anime.details.genres.any((genre) {
                  //   final isMatch = genre.name.toLowerCase() == selectedGenre!.name.toLowerCase();

                  //   return isMatch;
                  // });

                  return matchesSearchQuery;
                }).toList();

                  if (animeList.isEmpty) {
                    return const Center(child: Text('Аниме не найдено для выбранного сезона.'));
                  }

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: animeList.length,
                    itemBuilder: (context, index) {
                      final anime = animeList[index];
                      return AnimeTile(anime: anime);
                    },
                  );
                }

                if (state is ExplorerStateLoadingFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Что-то пошло не так'),
                        const Text('Пожалуйста, попробуйте еще раз позже'),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () {
                            explorerBloc.add(LoadExplorerEvent(season: selectedSeason, year: selectedYear));
                          },
                          child: const Text('Попробовать снова'),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(child: Text('Произошла ошибка. Попробуйте снова.'));
              },
            ),
          ),
        ),
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return '';
    return this[0].toUpperCase() + this.substring(1);
  }
}
