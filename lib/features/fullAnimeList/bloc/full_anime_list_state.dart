part of 'full_anime_list_bloc.dart';


 abstract class FullAnimeListState extends Equatable{}

class FullAnimeListInitial extends FullAnimeListState{

  @override
  List<Object?> get props => [];
  
}


class FullAnimeListLoading extends FullAnimeListState{

  @override
  List<Object?> get props => [];
  
}

class FullAnimeListLoaded extends FullAnimeListState{
FullAnimeListLoaded({required this.anime});
 final List<Anime> anime;

  @override
  List<Object?> get props => [anime];
  
}

class FullAnimeListLoadedFailure extends FullAnimeListState{
  FullAnimeListLoadedFailure(this.exception);
  final Object? exception;
  
  @override
  List<Object?> get props => [exception];
}