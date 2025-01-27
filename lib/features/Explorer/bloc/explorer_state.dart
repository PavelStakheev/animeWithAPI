part of 'explorer_bloc.dart';


abstract class ExplorerState extends Equatable{

   @override
  List<Object?> get props => [];

}

class ExplorerStateInitial extends ExplorerState{
  @override
  List<Object?> get props => [];

}

class ExplorerStateLoading extends ExplorerState{
  @override
  List<Object?> get props => [];

}

class ExplorerStateLoaded extends ExplorerState{
  ExplorerStateLoaded({required this.anime});
  final List<Anime> anime;
 

  @override
  List<Object?> get props => [anime];

}

class ExplorerStateGenresLoaded extends ExplorerState {
  final List<Genre> genres;

  ExplorerStateGenresLoaded(this.genres);

  @override
  List<Object> get props => [genres];
}


class ExplorerStateLoadingFailure extends ExplorerState{
  ExplorerStateLoadingFailure(this.exception);
  final Object? exception;
  
  @override
  List<Object?> get props => [exception];

}