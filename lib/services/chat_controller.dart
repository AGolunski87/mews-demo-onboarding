import '../models/property_details.dart';
import '../models/room.dart';
import '../models/branding.dart';
import 'onboarding_step.dart';

class ChatController {
  OnboardingStep _currentStep = OnboardingStep.propertyName;
  final Map<OnboardingStep, dynamic> _responses = {};

  final List<Room> _rooms = [];
  Room? _tempRoom;
  int? _totalRoomTypes;
  int _currentRoomIndex = 1;

  OnboardingStep get currentStep => _currentStep;

  String get prompt {
    final raw = onboardingPrompts[_currentStep] ?? '';
    return raw.replaceAll('[n]', _currentRoomIndex.toString());
  }

  Map<OnboardingStep, dynamic> get responses => _responses;
  List<Room> get rooms => _rooms;
  int? get totalRoomTypes => _totalRoomTypes;

  void saveResponse(dynamic value) {
    switch (_currentStep) {
      case OnboardingStep.numberOfRoomsTypes:
        _totalRoomTypes = int.tryParse(value.toString());
        break;
      default:
        _responses[_currentStep] = value;
    }
    _advanceStep();
  }

  void _advanceStep() {
    final allSteps = OnboardingStep.values;
    int currentIndex = allSteps.indexOf(_currentStep);
    if (currentIndex < allSteps.length - 1) {
      _currentStep = allSteps[currentIndex + 1];
    }
  }

  PropertyDetails buildPropertyDetails() {
    return PropertyDetails(
      propertyName: _responses[OnboardingStep.propertyName],
      propertyType: _responses[OnboardingStep.propertyType],
      region: _responses[OnboardingStep.region],
      numberOfRooms: _totalRoomTypes ?? _rooms.length,
      featureFocus: List<String>.from(
        _responses[OnboardingStep.featureFocus] ?? [],
      ),
      facilities: List<String>.from(
        _responses[OnboardingStep.facilities] ?? [],
      ),
      branding: Branding(
        logoUrl: _responses[OnboardingStep.brandingLogo] ?? '',
        themeColor: _responses[OnboardingStep.brandingColor] ?? '#336699',
      ),
      roomTypes: [], // deprecated for flat room model
      rooms: _rooms,
    );
  }

  void reset() {
    _currentStep = OnboardingStep.propertyName;
    _responses.clear();
    _rooms.clear();
    _tempRoom = null;
    _totalRoomTypes = null;
    _currentRoomIndex = 1;
  }
}
