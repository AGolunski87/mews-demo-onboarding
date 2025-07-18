// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomType _$RoomTypeFromJson(Map<String, dynamic> json) => RoomType(
  name: json['name'] as String,
  count: (json['count'] as num).toInt(),
  pricePerNight: (json['pricePerNight'] as num).toDouble(),
  housekeepingTimeMinutes: (json['housekeepingTimeMinutes'] as num).toInt(),
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$RoomTypeToJson(RoomType instance) => <String, dynamic>{
  'name': instance.name,
  'count': instance.count,
  'pricePerNight': instance.pricePerNight,
  'housekeepingTimeMinutes': instance.housekeepingTimeMinutes,
  'images': instance.images,
};
