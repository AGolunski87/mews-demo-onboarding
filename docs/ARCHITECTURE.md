# Project Architecture

This document explains the structure and flow of the *Mews Onboarding* Flutter
application. It is written for new contributors who are unfamiliar with the
code base.

## Overview

The application demonstrates a simple hotel onboarding wizard. The wizard is
presented as a chat interface where the user answers a sequence of questions.
Based on the answers the app builds a summary of property information and
displays a minimal demo dashboard.

## Folder Structure

```
lib/
  main.dart             Entry point. Creates `MyApp` and loads `IndexPage`.
  models/               Data models used throughout the app.
  screens/              Top level UI pages (chat bot, dashboard, preview).
  services/             Non-UI logic such as the onboarding controller.
  widgets/              Reusable UI widgets.
```

### lib/main.dart

Initialises Flutter and launches `MyApp`. `MyApp` defines the application theme
and displays `IndexPage` as the home screen.

### lib/screens/

- `index.dart` – Returns the main `HotelOnboardingBot` widget.
- `chatbot_ui.dart` – Stateful widget implementing the chat interface.
  Handles message sending, stores chat messages and navigates to the demo
  dashboard once the onboarding is complete.
- `demo_dashboard.dart` – Simple page shown after onboarding. Displays the
  generated property name and a back button.
- `onboarding_preview.dart` – Standalone preview of the onboarding form without
the chat logic. Mainly used for early UI iterations.

### lib/models/

Data classes describing the hotel setup. Most use JSON serialisation via
`json_annotation`.

- `PropertyDetails` – Aggregated information about the property.
- `RoomType` – Description of an individual room type.
- `Room` – Represents a single room number and occupancy.
- `Branding` – Basic branding information such as logo and theme colour.
- `AiMessage` – Wrapper for messages shown in the chat interface.

### lib/services/

- `onboarding_step.dart` – Enum listing each step of the onboarding process
  and a map of text prompts shown to the user.
- `chat_controller.dart` – Stores user responses and transitions between
  onboarding steps. Provides helper functions to build `PropertyDetails` and
  generate summary text.

### lib/widgets/

Reusable building blocks for the UI.

- `chat/ChatMessage` – Widget displaying a single chat bubble. Style changes
  depending on whether the message comes from the user or the bot.
- `shared/RoomTypeEditorCard` – Form card used by the drawer to edit details of
  a room type. Contains text fields for occupancy, price etc.
- `shared/drawer.dart` – Side drawer visible next to the chat. Shows progress
  summary, allows editing room types and finishing the setup.
- `shared/chips.dart` – Simple component rendering selectable feature chips.

## How the Chatbot Works

1. `ChatController` starts with `_currentStep` set to `propertyName` and
   contains a `_responses` map for storing answers.
2. `HotelOnboardingBot` initialises with a few system messages in `_messages`.
3. When the user sends a message, `_handleMessageSend` records the answer via
   `chatController.saveResponse`. This advances `_currentStep` and updates the
   prompt.
4. Once all questions are answered the controller builds a `PropertyDetails`
   instance. The UI then shows a short animation and navigates to
   `DemoDashboard`.

## Running the App

Ensure Flutter is installed. From the project root run:

```bash
flutter run -d chrome
```

This launches the web version with hot reload enabled.

## Contributing

- Follow the existing folder structure when adding new features.
- Keep widgets small and focussed. Larger flows should live inside `screens/`
  or `services/`.
- Write tests under the `test/` directory when possible.

