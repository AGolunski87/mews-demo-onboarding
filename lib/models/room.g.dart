// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
  roomNumber: json['roomNumber'] as String,
  typeName: json['typeName'] as String,
  maxOccupancy: (json['maxOccupancy'] as num).toInt(),
);

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
  'roomNumber': instance.roomNumber,
  'typeName': instance.typeName,
  'maxOccupancy': instance.maxOccupancy,
};
