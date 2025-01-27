import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre {
  final String name;
  final int malId;

  Genre({required this.name,required this.malId});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      malId: json['mal_id'],
      name: json['name'],
    );
  }
}
