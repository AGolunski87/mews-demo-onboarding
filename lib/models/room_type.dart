import 'package:json_annotation/json_annotation.dart';

part 'room_type.g.dart';

@JsonSerializable()
class RoomType {
  final String name;
  final int count;
  final double pricePerNight;
  final int housekeepingTimeMinutes;
  final List<String> images;

  RoomType({
    required this.name,
    required this.count,
    required this.pricePerNight,
    required this.housekeepingTimeMinutes,
    required this.images,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeFromJson(json);
  Map<String, dynamic> toJson() => _$RoomTypeToJson(this);

  RoomType copyWith({
    String? name,
    int? count,
    double? pricePerNight,
    int? housekeepingTimeMinutes,
    List<String>? images,
  }) {
    return RoomType(
      name: name ?? this.name,
      count: count ?? this.count,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      housekeepingTimeMinutes:
          housekeepingTimeMinutes ?? this.housekeepingTimeMinutes,
      images: images ?? this.images,
    );
  }
}
