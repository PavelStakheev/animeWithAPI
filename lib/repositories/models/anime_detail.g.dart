// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeDetail _$AnimeDetailFromJson(Map<String, dynamic> json) => AnimeDetail(
      trailer: json['trailer'] != null ? Trailer.fromJson(json['trailer']) : null,
      title: json['title'] as String?,
      airing: json['airing'] as bool?,
      synopsis: json['synopsis'] as String?,
      realise: json['aired']['prop']['from']['year'] as num?,
      score: (json['score'] as num?)?.toDouble(),
      members: (json['members'] as num?)?.toInt(),
      rank: (json['rank'] as num?)?.toInt(),
      episodes: (json['episodes'] as num?)?.toInt(),
      images: json['images'] as Map<String, dynamic>?,
      genres: (json['genres'] as List<dynamic>?)?.map((genreJson) => Genre.fromJson(genreJson)).toList() ?? [],
    );

Map<String, dynamic> _$AnimeDetailToJson(AnimeDetail instance) =>
    <String, dynamic>{
      'episodes': instance.episodes,
      'rank': instance.rank,
      'images': {
        'jpg': {
          'image_url': instance.images?['jpg']['image_url'], // Убедитесь, что вы правильно получаете URL изображения
        }
      },
      'title': instance.title,
      'airing': instance.airing,
      'synopsis': instance.synopsis,
      'aired': instance.realise,
      'score': instance.score,
      'members': instance.members,
      'genres': instance.genres,
      'trailer': instance.trailer?.toJson(),
    };
