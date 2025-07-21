import 'package:json_annotation/json_annotation.dart';
import 'room_type.dart';
import 'branding.dart';
import 'room.dart';

part 'property_details.g.dart';

@JsonSerializable()
class PropertyDetails {
  final String propertyName;
  final String propertyType;
  final String region;
  final int numberOfRooms;
  final List<String> featureFocus;
  final List<String> facilities;
  final String propertySummary; // e.g., "A cozy hotel in the city center"

  final List<RoomType> roomTypes; // e.g., "Deluxe", "Suite", etc.
  final List<Room> rooms; // One entry per room, by number

  PropertyDetails({
    required this.propertyName,
    required this.propertyType,
    required this.region,
    required this.numberOfRooms,
    required this.featureFocus,
    required this.facilities,
    required this.roomTypes,
    required this.rooms,
    required this.propertySummary,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) =>
      _$PropertyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyDetailsToJson(this);
}
