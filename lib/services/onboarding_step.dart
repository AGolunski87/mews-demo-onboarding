enum OnboardingStep {
  welcome,
  email,
  emailVerify,
  emailConfirmed,
  propertyName,
  propertyLocation,
  featureFocus,
  numberOfRoomTypes,
  roomCardInstructions,
  summaryConfirm,
}

final Map<OnboardingStep, String> onboardingPrompts = {
  OnboardingStep.welcome:
      "Getting started with Mews is simple.\nI can get you set up in just a few seconds. I’ll need a few details first.",
  OnboardingStep.email:
      "To prove you're human, please provide a valid email address.",
  OnboardingStep.emailVerify: "✅ Email sent — please verify.",
  OnboardingStep.emailConfirmed: "✅ Email verified successfully.",
  OnboardingStep.propertyName: "What’s the name of your property?",
  OnboardingStep.propertyLocation: "Where is your property located?",
  OnboardingStep.featureFocus:
      "Use the chips below to tell me what features you’d like to see (e.g. Booking, Front Desk, Payments).",

  OnboardingStep.numberOfRoomTypes:
      "How many room types does your property have?",
  OnboardingStep.roomCardInstructions:
      "Please complete the room type cards in the drawer. When you’re ready, click Finish Setup — or Edit to add more.",
  OnboardingStep.summaryConfirm:
      "🎉 All done! Your personalized Mews demo is ready.\n\n👉 /front-desk\n👉 /booking\n👉 /housekeeping",
};
