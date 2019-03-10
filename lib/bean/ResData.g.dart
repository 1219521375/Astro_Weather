// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResData _$ResDataFromJson(Map<String, dynamic> json) {
  return ResData(
      json['product'] as String,
      json['init'] as String,
      (json['dataseries'] as List)
          ?.map((e) => e == null
              ? null
              : WeatherData.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ResDataToJson(ResData instance) => <String, dynamic>{
      'product': instance.product,
      'init': instance.init,
      'dataseries': instance.dataseries
    };
