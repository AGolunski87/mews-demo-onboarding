// ===========================
// 1. models/room_type.dart
// ===========================
import 'package:json_annotation/json_annotation.dart';

part 'room_type.g.dart';

@JsonSerializable()
class RoomType {
  final String name;
  final double pricePerNight;
  final int numberOfRooms;
  final int maxOccupancy;

  RoomType({
    required this.name,
    required this.pricePerNight,
    required this.numberOfRooms,
    required this.maxOccupancy,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeFromJson(json);
  Map<String, dynamic> toJson() => _$RoomTypeToJson(this);
}
