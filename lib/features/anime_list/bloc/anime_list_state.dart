part of 'anime_list_bloc.dart';

abstract class AnimeListState extends Equatable{

}

class AnimeListInitial extends AnimeListState{
  @override
  List<Object?> get props => [];

}

class AnimeListLoading extends AnimeListState{
  @override
  List<Object?> get props => [];

}

class AnimeListLoaded extends AnimeListState{
    AnimeListLoaded({
      required this.anime,
      required this.anime1,
      required this.anime2
    
      });

    final List<Anime> anime;
    final List<Anime> anime1;
    final List<Anime> anime2;
   
  

  @override
  List<Object?> get props => [anime,anime1,anime2];
 
}

class AnimeListLoadingFailure extends AnimeListState{
  AnimeListLoadingFailure({this.exception});

  final Object? exception;

  

  @override
  List<Object?> get props => [exception];

}