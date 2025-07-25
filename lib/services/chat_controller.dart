import '../models/property_details.dart';
import '../models/branding.dart';
import '../models/room_type.dart';
import 'onboarding_step.dart';
import 'user_input_service.dart';

class ChatController {
  OnboardingStep _currentStep = OnboardingStep.welcome;
  final Map<OnboardingStep, dynamic> _responses = {};

  int? _totalRoomTypes = 0;
  int _currentRoomIndex = 1;
  int _totalRooms = 0;

  List<RoomType> _roomTypes = [];

  OnboardingStep get currentStep => _currentStep;

  String get prompt {
    final raw = onboardingPrompts[_currentStep] ?? '';
    return raw.replaceAll('[n]', _currentRoomIndex.toString());
  }

  Map<OnboardingStep, dynamic> get responses => _responses;
  int? get totalRoomTypes => _totalRoomTypes;
  int get totalRooms => _totalRooms;

  void setTotalRooms(int count) {
    _totalRooms = count;
  }

  void setRoomTypes(List<RoomType> types) {
    _roomTypes = types;
  }

  void saveResponse(dynamic value) {
    switch (_currentStep) {
      case OnboardingStep.numberOfRoomTypes:
        _totalRoomTypes = int.tryParse(value.toString());
        break;
      default:
        _responses[_currentStep] = value;
    }
    _advanceStep();
  }

  void _advanceStep() {
    final steps = OnboardingStep.values;
    int currentIndex = steps.indexOf(_currentStep);

    if (_currentStep == OnboardingStep.numberOfRoomTypes) {
      _currentStep = OnboardingStep.roomCardInstructions;
      return;
    }

    if (currentIndex < steps.length - 1) {
      _currentStep = steps[currentIndex + 1];
    }
  }

  void finalizeSetup() {
    if (_currentStep == OnboardingStep.roomCardInstructions) {
      _advanceStep();
    }
  }

  PropertyDetails buildPropertyDetails() {
    return PropertyDetails(
      propertyName: _responses[OnboardingStep.propertyName],
      propertyType: _responses[OnboardingStep.propertyType],
      region: _responses[OnboardingStep.propertyLocation],
      numberOfRooms: _totalRooms,
      featureFocus: List<String>.from(
        _responses[OnboardingStep.featureFocus] ?? [],
      ),
      facilities: const [],
      roomTypes: _roomTypes,
      rooms: const [],
      propertySummary: _responses[OnboardingStep.propertySummary],
    );
  }

  String getReadableSummary() {
    return UserInputService().getPropertySummary();
  }

  void reset() {
    _currentStep = OnboardingStep.welcome;
    _responses.clear();
    _totalRoomTypes = null;
    _currentRoomIndex = 1;
    _totalRooms = 0;
    _roomTypes.clear();
  }
}
