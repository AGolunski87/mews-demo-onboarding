import '../models/property_details.dart';
import '../models/branding.dart';
import 'onboarding_step.dart';

class ChatController {
  OnboardingStep _currentStep = OnboardingStep.welcome;
  final Map<OnboardingStep, dynamic> _responses = {};

  int? _totalRoomTypes = 0;
  int _currentRoomIndex = 1;
  int _totalRooms = 0;

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

    // Stop to wait for user to finish drawer setup
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
      _advanceStep(); // Proceed to summaryConfirm
    }
  }

  PropertyDetails buildPropertyDetails() {
    return PropertyDetails(
      propertyName: _responses[OnboardingStep.propertyName],
      propertyType: '', // No longer asked
      region: _responses[OnboardingStep.propertyLocation],
      numberOfRooms: _totalRooms,
      featureFocus: List<String>.from(
        _responses[OnboardingStep.featureFocus] ?? [],
      ),
      facilities: const [], // No longer collected
      branding: Branding(
        logoUrl: '', // Not collected
        themeColor: '#336699', // Default fallback
      ),
      roomTypes: [],
      rooms: const [],
    );
  }

  String getReadableSummary() {
    final name = _responses[OnboardingStep.propertyName];
    final region = _responses[OnboardingStep.propertyLocation];
    final count = _totalRoomTypes;

    if (name == null || region == null || count == null) return '';

    return "$name, with $count room types in $region.";
  }

  void reset() {
    _currentStep = OnboardingStep.welcome;
    _responses.clear();
    _totalRoomTypes = null;
    _currentRoomIndex = 1;
    _totalRooms = 0;
  }
}
