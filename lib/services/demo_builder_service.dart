import 'user_input_service.dart';
import '../models/property_details.dart';

class DemoBuilderService {
  PropertyDetails buildDemoProperty() {
    final input = UserInputService();
    final details = input.buildPropertyDetails();

    return details;
  }
}
