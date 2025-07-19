enum OnboardingStep {
  propertyName,
  propertyType,
  region,
  numberOfRoomsTypes,
  brandingLogo,
  brandingColor,
  featureFocus,
  facilities,
  roomType,
  roomOccupancy,
  summaryConfirm,
}

const Map<OnboardingStep, String> onboardingPrompts = {
  OnboardingStep.propertyName: "What’s the name of your hotel?",
  OnboardingStep.propertyType: "What type of property is it?",
  OnboardingStep.region: "Where is it located?",
  OnboardingStep.numberOfRoomsTypes:
      "How many room types does your property have eg, deluxe family ... ?",
  OnboardingStep.brandingLogo: "Upload your logo or skip.",
  OnboardingStep.brandingColor: "Pick a theme color (or use default).",
  OnboardingStep.featureFocus: "What Mews features are you most interested in?",
  OnboardingStep.facilities: "Any special facilities you'd like to include?",
  OnboardingStep.roomType: "What type is room #[n]?",
  OnboardingStep.roomOccupancy: "What’s the max occupancy for room #[n]?",
  OnboardingStep.summaryConfirm:
      "Here’s your setup. Ready to generate your demo?",
};
