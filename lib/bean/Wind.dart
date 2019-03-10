import 'package:json_annotation/json_annotation.dart';

part 'Wind.g.dart';

@JsonSerializable()
class Wind {
  String direction;
  int speed;

  Wind(this.direction, this.speed);

 factory Wind.fromJson(Map<String,dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}