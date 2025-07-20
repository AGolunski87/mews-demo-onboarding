// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomType _$RoomTypeFromJson(Map<String, dynamic> json) => RoomType(
  name: json['name'] as String,
  pricePerNight: (json['pricePerNight'] as num).toDouble(),
  numberOfRooms: (json['numberOfRooms'] as num).toInt(),
  maxOccupancy: (json['maxOccupancy'] as num).toInt(),
);

Map<String, dynamic> _$RoomTypeToJson(RoomType instance) => <String, dynamic>{
  'name': instance.name,
  'pricePerNight': instance.pricePerNight,
  'numberOfRooms': instance.numberOfRooms,
  'maxOccupancy': instance.maxOccupancy,
};
