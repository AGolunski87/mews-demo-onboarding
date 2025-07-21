import '../models/property_details.dart';
import '../models/room.dart';
import '../models/room_type.dart';

class UserInputService {
  static final UserInputService _instance = UserInputService._internal();
  factory UserInputService() => _instance;

  UserInputService._internal();

  final Map<String, dynamic> responses = {};
  final List<RoomType> roomTypes = [];
  final List<Room> rooms = [];

  void saveResponse(String key, dynamic value) {
    responses[key] = value;
  }

  dynamic getResponse(String key) {
    return responses[key];
  }

  void addOrUpdateRoomType(RoomType type) {
    final index = roomTypes.indexWhere((t) => t.name == type.name);
    if (index >= 0) {
      roomTypes[index] = type;
    } else {
      roomTypes.add(type);
    }
  }

  /// Builds a PropertyDetails object with total rooms calculated
  PropertyDetails buildPropertyDetails() {
    final totalRooms = roomTypes.fold<int>(
      0,
      (sum, roomType) => sum + roomType.numberOfRooms,
    );

    return PropertyDetails(
      propertyName: responses['propertyName'] ?? '',
      propertyType: responses['propertyType'] ?? '',
      region: responses['region'] ?? '',
      numberOfRooms: totalRooms,
      featureFocus: List<String>.from(responses['featureFocus'] ?? []),
      facilities: List<String>.from(responses['facilities'] ?? []),
      roomTypes: roomTypes,
      rooms: rooms,
      propertySummary: responses['propertySummary'] ?? '',
    );
  }

  /// Returns the lowest nightly rate across all room types
  double getLowestNightlyRate() {
    if (roomTypes.isEmpty) return 0.0;
    return roomTypes
        .map((r) => r.pricePerNight)
        .reduce((a, b) => a < b ? a : b);
  }

  /// Generates a readable summary of the property
  String getPropertySummary() {
    final name = responses['propertyName']?.toString().trim() ?? '';
    final type = responses['propertyType']?.toString().trim() ?? '';
    final region = responses['region']?.toString().trim() ?? '';
    final summary = responses['propertySummary']?.toString().trim() ?? '';

    final totalRooms = roomTypes.fold<int>(
      0,
      (sum, roomType) => sum + roomType.numberOfRooms,
    );

    final rate = getLowestNightlyRate();
    final rateFormatted = rate > 0
        ? "\$${rate.toStringAsFixed(2)}/night"
        : "TBD";

    final namePart = name.isNotEmpty ? "**$name**" : "This property";
    final typePart = type.isNotEmpty ? "a ${type.toLowerCase()}" : "a property";
    final locationPart = region.isNotEmpty ? "located in **$region**" : "";

    final description = summary.isNotEmpty ? "$summary\n\n" : "";

    return "$description🏨 $namePart is $typePart with **$totalRooms room${totalRooms != 1 ? 's' : ''}**, "
        "$locationPart.\n💰 Rates start from **$rateFormatted**";
  }

  void clear() {
    responses.clear();
    roomTypes.clear();
    rooms.clear();
  }
}
