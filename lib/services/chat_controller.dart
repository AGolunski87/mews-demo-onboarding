import '../models/property_details.dart';
import '../models/room_type.dart';
import '../models/branding.dart';
import 'onboarding_step.dart';

class ChatController {
  OnboardingStep _currentStep = OnboardingStep.propertyName;
  final Map<OnboardingStep, dynamic> _responses = {};
  final List<RoomType> _rooms = [];
  RoomType? _tempRoom;

  OnboardingStep get currentStep => _currentStep;
  String get prompt => onboardingPrompts[_currentStep] ?? '';
  Map<OnboardingStep, dynamic> get responses => _responses;
  List<RoomType> get rooms => _rooms;

  void saveResponse(dynamic value) {
    switch (_currentStep) {
      case OnboardingStep.roomName:
        _tempRoom = RoomType(
          name: value,
          count: 0,
          pricePerNight: 0,
          housekeepingTimeMinutes: 0,
          images: [],
        );
        break;
      case OnboardingStep.roomCount:
        _tempRoom = _tempRoom?.copyWith(count: value);
        break;
      case OnboardingStep.roomPrice:
        _tempRoom = _tempRoom?.copyWith(pricePerNight: value);
        break;
      case OnboardingStep.roomCleaningTime:
        _tempRoom = _tempRoom?.copyWith(housekeepingTimeMinutes: value);
        break;
      case OnboardingStep.roomImages:
        _tempRoom = _tempRoom?.copyWith(images: value);
        break;
      case OnboardingStep.askAddAnotherRoom:
        if (value == true && _tempRoom != null) {
          _rooms.add(_tempRoom!);
          _tempRoom = null;
          _currentStep = OnboardingStep.roomName;
          return;
        } else if (value == false && _tempRoom != null) {
          _rooms.add(_tempRoom!);
          _tempRoom = null;
        }
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
      numberOfRooms: _responses[OnboardingStep.numberOfRooms],
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
      roomTypes: _rooms,
    );
  }

  void reset() {
    _currentStep = OnboardingStep.propertyName;
    _responses.clear();
    _rooms.clear();
    _tempRoom = null;
  }
}
