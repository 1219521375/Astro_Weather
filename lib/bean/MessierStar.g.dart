// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessierStar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessierStar _$MessierStarFromJson(Map<String, dynamic> json) {
  return MessierStar(
      json['m_num'] as String,
      json['ngc_num'] as String,
      json['right_asc'] as String,
      json['declination'] as String,
      json['sight_size'] as String,
      (json['sight_bright'] as num)?.toDouble(),
      json['ly'] as int,
      json['constellation'] as String,
      json['class'] as String,
      json['others'] as String);
}

Map<String, dynamic> _$MessierStarToJson(MessierStar instance) =>
    <String, dynamic>{
      'm_num': instance.m_num,
      'ngc_num': instance.ngc_num,
      'right_asc': instance.right_asc,
      'declination': instance.declination,
      'sight_size': instance.sight_size,
      'sight_bright': instance.sight_bright,
      'ly': instance.ly,
      'constellation': instance.constellation,
      'class': instance.kind,
      'others': instance.others
    };
