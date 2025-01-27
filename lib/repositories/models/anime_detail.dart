import 'package:jikan_api2/repositories/models/genre.dart';
import 'package:jikan_api2/repositories/models/trailer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anime_detail.g.dart';

@JsonSerializable()

class AnimeDetail {
AnimeDetail( 
{
this.trailer,
this.title,
this.airing,
this.synopsis,
this.realise,
this.score,
this.members,
this.rank,
this.episodes,
this.images,
required this.genres
});

@JsonKey(name: 'episodes')
final int? episodes;

@JsonKey(name: 'rank')
final int? rank;

@JsonKey(name: 'images')
final Map<String, dynamic>? images;
String? get imageUrl => images?['jpg']?['image_url'];

@JsonKey(name: 'title')
final String? title;

@JsonKey(name: 'airing')
final bool? airing;

@JsonKey(name: 'synopsis')
final String? synopsis;

@JsonKey(name: 'aired')
final num? realise;

@JsonKey(name: 'score')
final double? score;

@JsonKey(name: 'members')
final int? members;

@JsonKey(name: 'genres')
final List<Genre> genres;


final Trailer? trailer;

factory AnimeDetail.fromJson(Map<String, dynamic> json) => _$AnimeDetailFromJson(json);

Map<String, dynamic> toJson() => _$AnimeDetailToJson(this);

}