import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  final String roomNumber;
  final String typeName;
  final int maxOccupancy;

  Room({
    required this.roomNumber,
    required this.typeName,
    required this.maxOccupancy,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);

  Room copyWith({String? roomNumber, String? typeName, int? maxOccupancy}) {
    return Room(
      roomNumber: roomNumber ?? this.roomNumber,
      typeName: typeName ?? this.typeName,
      maxOccupancy: maxOccupancy ?? this.maxOccupancy,
    );
  }
}
