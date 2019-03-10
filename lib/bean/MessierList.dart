import 'package:astro_weather/bean/MessierStar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MessierList.g.dart';
///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class MessierList {

  List<MessierStar> stars;

  MessierList(this.stars);

  factory MessierList.fromJson(Map<String,dynamic> json) => _$MessierListFromJson(json);
  Map<String, dynamic> toJson() => _$MessierListToJson(this);

}