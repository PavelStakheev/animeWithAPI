part of 'anime_detail_bloc.dart';

abstract class AnimeDetailEvent extends Equatable{
const AnimeDetailEvent();
  
@override
  List<Object?> get props => [];
}

class LoadAnimeDetail extends AnimeDetailEvent{
 const LoadAnimeDetail({required this.currencyCode});
  final int currencyCode;

  @override
  List<Object?> get props => super.props..add(currencyCode);

}