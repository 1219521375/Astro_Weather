// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) {
  return WeatherData(
      json['timepoint'] as int,
      json['cloudcover'] as int,
      json['seeing'] as int,
      json['transparency'] as int,
      json['lifted_index'] as int,
      json['rh2m'] as int,
      json['wind10m'] == null
          ? null
          : Wind.fromJson(json['wind10m'] as Map<String, dynamic>),
      json['temp2m'] as int,
      json['prec_type'] as String);
}

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'timepoint': instance.timepoint,
      'cloudcover': instance.cloudcover,
      'seeing': instance.seeing,
      'transparency': instance.transparency,
      'lifted_index': instance.lifted_index,
      'rh2m': instance.rh2m,
      'wind10m': instance.wind10m,
      'temp2m': instance.temp2m,
      'prec_type': instance.prec_type
    };
