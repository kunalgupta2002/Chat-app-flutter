import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class PixelfordImage {
  String id;
  String name;
  String type;
  String available;

  PixelfordImage({
    required this.id,
    required this.name,
    required this.type,
    required this.available,
  });

  factory PixelfordImage.fromJson(Map<String, dynamic> json) => _$PixelfordImageFromJson(json);

  String get urlFullSize => 'https://simple-books-api.glitch.me/books/';

  Map<String, dynamic> toJson() => _$PixelfordImageToJson(this);
}
