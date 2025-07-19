import '../models/property_details.dart';
import '../models/room.dart';
import '../models/branding.dart';
import 'onboarding_step.dart';

class ChatController {
  OnboardingStep _currentStep = OnboardingStep.propertyName;
  final Map<OnboardingStep, dynamic> _responses = {};

  final List<Room> _rooms = [];
  Room? _tempRoom;
  int? _totalRoomTypes = 0;
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
      numberOfRooms: _rooms.length,
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
      roomTypes: [],
      rooms: _rooms,
    );
  }

  String getReadableSummary() {
    final name = _responses[OnboardingStep.propertyName] ?? 'My property';
    final type = _responses[OnboardingStep.propertyType] ?? 'a hotel';
    final count = _totalRoomTypes ?? _rooms.length;
    final region = _responses[OnboardingStep.region] ?? 'an unknown location';
    return "My property, $name, $type with $count rooms in $region.";
  }

  void finalizeSetup() {
    // Optional: logging or local completion marker
    if (_currentStep == OnboardingStep.numberOfRoomsTypes) {
      _advanceStep();
    }
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
