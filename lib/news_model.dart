import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class News {
  final int? id;
  final String title;
  final String description;
  final String image;
  final String date;

  News({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  News copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    String? date,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      date: date ?? this.date,
    );
  }
}
