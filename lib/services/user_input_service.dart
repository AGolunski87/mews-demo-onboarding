import '../models/property_details.dart';
import '../models/room.dart';
import '../models/room_type.dart';
import '../models/branding.dart';

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

  PropertyDetails buildPropertyDetails() {
    return PropertyDetails(
      propertyName: responses['propertyName'] ?? '',
      propertyType: responses['propertyType'] ?? '',
      region: responses['region'] ?? '',
      numberOfRooms: responses['numberOfRooms'] ?? 0,
      featureFocus: List<String>.from(responses['featureFocus'] ?? []),
      facilities: List<String>.from(responses['facilities'] ?? []),
      roomTypes: roomTypes,
      rooms: rooms,
    );
  }

  void clear() {
    responses.clear();
    roomTypes.clear();
    rooms.clear();
  }
}
