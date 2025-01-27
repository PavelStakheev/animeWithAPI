import 'package:json_annotation/json_annotation.dart';

part 'trailer.g.dart';

@JsonSerializable()
class Trailer {
  final String? url;

  Trailer({this.url});

  factory Trailer.fromJson(Map<String, dynamic> json) => _$TrailerFromJson(json);
  Map<String, dynamic> toJson() => _$TrailerToJson(this);
}