import 'package:json_annotation/json_annotation.dart';
import 'dart:core';

import 'package:astro_weather/bean/Wind.dart';


// user.g.dart 将在我们运行生成命令后自动生成
part 'WeatherData.g.dart';
///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class WeatherData {
//  {
//   		"timepoint" : 3,//时间
//   		"cloudcover" : 8, 云量
//   		"seeing" : 6, 视宁度
//   		"transparency" : 4, 透明度
//   		"lifted_index" : -4, 抬升指数  ->大气不稳定度
//   		"rh2m" : 10, 湿度
//   		"wind10m" : {
//   			"direction" : "S", 风向
//   			"speed" : 3 风速
//   		}, 10米风
//   		"temp2m" : 28, 温度
//   		"prec_type" : "rain" 降水类型
//   	},
  int timepoint;
  int cloudcover;
  int seeing;
  int transparency;
  int lifted_index;
  int rh2m;
  Wind wind10m;
  int temp2m;
  String prec_type;

  WeatherData(this.timepoint, this.cloudcover, this.seeing, this.transparency,
      this.lifted_index, this.rh2m, this.wind10m, this.temp2m, this.prec_type);


  factory WeatherData.fromJson(Map<String,dynamic> json) => _$WeatherDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);

}