import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/chat_controller.dart';
import '../services/onboarding_step.dart';
import '../models/property_details.dart';
import 'demo_dashboard.dart';
import '/widgets/shared/components.dart';
import '/widgets/shared/drawer.dart';
import '../models/ai_message.dart';
import '../widgets/chat/chat_message.dart';

class HotelOnboardingBot extends StatefulWidget {
  const HotelOnboardingBot({super.key});

  @override
  State<HotelOnboardingBot> createState() => _HotelOnboardingBotState();
}

class _HotelOnboardingBotState extends State<HotelOnboardingBot> {
  final TextEditingController _textController = TextEditingController();
  final ChatController chatController = ChatController();
  final List<AiMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.addAll([
      AiMessage.system(
        "🧙‍♂️ Welcome, I can get you started with Mews in seconds.",
      ),
      AiMessage.ai(chatController.prompt),
    ]);
  }

  void _handleMessageSend(String input) {
    if (input.isEmpty) return;

    setState(() {
      _messages.add(AiMessage.user(input));
      chatController.saveResponse(input);

      if (chatController.currentStep == OnboardingStep.summaryConfirm) {
        final details = chatController.buildPropertyDetails();
        _messages.add(
          AiMessage.functionCall(
            functionName: "generateDemo",
            arguments: details.toJson().toString(),
          ),
        );
        _showScrollDialog(context);
      } else {
        _messages.add(AiMessage.ai(chatController.prompt));
      }

      _textController.clear();
    });
  }

  void _showScrollDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              "web/assets/building.json",
              repeat: false,
              onLoaded: (_) async {
                await Future.delayed(const Duration(seconds: 2));
                if (mounted) {
                  Navigator.of(context).pop();
                  _navigateToDashboard();
                }
              },
            ),
            const SizedBox(height: 16),
            const Text("Unfolding your demo..."),
          ],
        ),
      ),
    );
  }

  void _navigateToDashboard() {
    final propertyName = chatController.buildPropertyDetails().propertyName;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DemoDashboard(propertyName: propertyName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0E7),
      body: Row(
        children: [
          // Left: Chat Area
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Lottie.asset('web/assets/bot.json', height: 120),
                const Text(
                  "Onboarding Wizard",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return ChatMessage(message: msg);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          onSubmitted: _handleMessageSend,
                          decoration: const InputDecoration(
                            hintText: 'Your answer here...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () =>
                            _handleMessageSend(_textController.text.trim()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Right: Always-Visible Drawer
          RoomTypeDrawer(
            numberOfRoomTypes: chatController.totalRoomTypes ?? 4,
            summaryText: chatController.getReadableSummary(),
            onFinish: () {
              chatController.saveResponse('done');
              final nextStep = chatController.currentStep;

              setState(() {
                _messages.add(AiMessage.user("✅ Room setup complete"));

                if (nextStep == OnboardingStep.summaryConfirm) {
                  final details = chatController.buildPropertyDetails();
                  _messages.add(
                    AiMessage.functionCall(
                      functionName: "generateDemo",
                      arguments: details.toJson().toString(),
                    ),
                  );
                  _showScrollDialog(context);
                } else {
                  _messages.add(AiMessage.ai(chatController.prompt));
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
