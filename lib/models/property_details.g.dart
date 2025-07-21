// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDetails _$PropertyDetailsFromJson(Map<String, dynamic> json) =>
    PropertyDetails(
      propertyName: json['propertyName'] as String,
      propertyType: json['propertyType'] as String,
      region: json['region'] as String,
      numberOfRooms: (json['numberOfRooms'] as num).toInt(),
      featureFocus: (json['featureFocus'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      facilities: (json['facilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      roomTypes: (json['roomTypes'] as List<dynamic>)
          .map((e) => RoomType.fromJson(e as Map<String, dynamic>))
          .toList(),
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => Room.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropertyDetailsToJson(PropertyDetails instance) =>
    <String, dynamic>{
      'propertyName': instance.propertyName,
      'propertyType': instance.propertyType,
      'region': instance.region,
      'numberOfRooms': instance.numberOfRooms,
      'featureFocus': instance.featureFocus,
      'facilities': instance.facilities,
      'roomTypes': instance.roomTypes,
      'rooms': instance.rooms,
    };
