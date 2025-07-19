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

  OnboardingStep.facilities: "Any special facilities you'd like to include?",

  OnboardingStep.summaryConfirm:
      "Here’s your setup. Ready to generate your demo?",
};
