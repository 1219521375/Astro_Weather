// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Wind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(json['direction'] as String, json['speed'] as int);
}

Map<String, dynamic> _$WindToJson(Wind instance) =>
    <String, dynamic>{'direction': instance.direction, 'speed': instance.speed};
