// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessierList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessierList _$MessierListFromJson(Map<String, dynamic> json) {
  return MessierList((json['stars'] as List)
      ?.map((e) =>
          e == null ? null : MessierStar.fromJson(e as Map<String, dynamic>))
      ?.toList());
}


Map<String, dynamic> _$MessierListToJson(MessierList instance) =>
    <String, dynamic>{'stars': instance.stars};
