import 'dart:core';
import 'package:astro_weather/bean/WeatherData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ResData.g.dart';
///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class ResData {
  String product;
  String init;
  List<WeatherData> dataseries;


  ResData(this.product, this.init, this.dataseries);

  factory ResData.fromJson(Map<String,dynamic> json) => _$ResDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResDataToJson(this);

}