import 'package:json_annotation/json_annotation.dart';
import 'room_type.dart';
import 'branding.dart';

part 'property_details.g.dart';

@JsonSerializable()
class PropertyDetails {
  final String propertyName;
  final String propertyType;
  final String region;
  final int numberOfRooms;
  final List<String> featureFocus;
  final List<String> facilities;
  final Branding branding;
  final List<RoomType> roomTypes;

  PropertyDetails({
    required this.propertyName,
    required this.propertyType,
    required this.region,
    required this.numberOfRooms,
    required this.featureFocus,
    required this.facilities,
    required this.branding,
    required this.roomTypes,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) =>
      _$PropertyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyDetailsToJson(this);
}
