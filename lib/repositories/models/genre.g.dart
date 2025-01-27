// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      name: json['name'] as String,
      malId: (json['malId'] as num).toInt(),
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'name': instance.name,
      'malId': instance.malId,
    };
