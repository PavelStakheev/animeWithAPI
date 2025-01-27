part of 'anime_detail_bloc.dart';

class AnimeDetailState extends Equatable{
  const AnimeDetailState();


  @override
  List<Object?> get props => [];
}

class AnimeDetailLoading extends AnimeDetailState{
  @override
  List<Object?> get props => [];

}

class AnimeDetailLoaded extends AnimeDetailState{
  const AnimeDetailLoaded(this.anime);
  final Anime anime;

  @override
  List<Object?> get props => [anime];

}

class AnimeDetailLoadingFailure extends AnimeDetailState{
  const AnimeDetailLoadingFailure(this.exception);

  final Object? exception;

  @override
  List<Object?> get props => [exception];

}