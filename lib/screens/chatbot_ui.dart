import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:lottie/lottie.dart';
import 'demo_dashboard.dart';

class AiMessage {
  final String text;
  final bool isUser;
  final bool isFunctionCall;
  final String? functionName;
  final String? arguments;

  AiMessage.user(this.text)
    : isUser = true,
      isFunctionCall = false,
      functionName = null,
      arguments = null;

  AiMessage.ai(this.text)
    : isUser = false,
      isFunctionCall = false,
      functionName = null,
      arguments = null;

  AiMessage.system(this.text)
    : isUser = false,
      isFunctionCall = false,
      functionName = null,
      arguments = null;

  AiMessage.functionCall({required this.functionName, required this.arguments})
    : isUser = false,
      isFunctionCall = true,
      text = "🧾 Casting scroll spell...";
}

class HotelOnboardingBot extends StatefulWidget {
  const HotelOnboardingBot({super.key});

  @override
  State<HotelOnboardingBot> createState() => _HotelOnboardingBotState();
}

class _HotelOnboardingBotState extends State<HotelOnboardingBot> {
  final TextEditingController _textController = TextEditingController();

  final List<AiMessage> _messages = [
    AiMessage.system(
      "🧙‍♂️ Welcome, I can get you started with Mews in seconds.",
    ),
    AiMessage.ai("I just need a few enchanted details first."),
  ];

  int _step = 0;
  String propertyName = '';
  String propertyType = '';
  String region = '';
  String focus = '';

  void _handleMessageSend(String input) {
    if (input.isEmpty) return;
    setState(() {
      _messages.add(AiMessage.user(input));
      _step++;
      _handleNextStep(input);
      _textController.clear();
    });
  }

  void _handleNextStep(String input) {
    switch (_step) {
      case 1:
        propertyName = input;
        _messages.add(
          AiMessage.ai("Great! What type of magical property is it?"),
        );
        break;
      case 2:
        propertyType = input;
        _messages.add(
          AiMessage.ai(
            "Wondrous! Where is it located, or how many rooms does it have?",
          ),
        );
        break;
      case 3:
        region = input;
        _messages.add(AiMessage.ai("And your focus of power?"));
        break;
      case 4:
        focus = input;
        _messages.add(AiMessage.ai("I'm conjuring your personalized demo..."));
        _messages.add(
          AiMessage.functionCall(
            functionName: "generateDemo",
            arguments:
                "{ property: '$propertyName', type: '$propertyType', region: '$region', focus: '$focus' }",
          ),
        );
        Future.delayed(const Duration(milliseconds: 600), () {
          _showScrollDialog(context);
        });
        break;
    }
  }

  List<String> _getSuggestions() {
    switch (_step) {
      case 1:
        return [
          'Boutique Tower',
          'Resort Keep',
          'Forest Hostel',
          'B&B Cottage',
        ];
      case 3:
        return ['🧹 Housekeeping', '🗝️ Front Desk', '🔮 Self Check-in'];
      default:
        return [];
    }
  }

  void _navigateToDashboard() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DemoDashboard(propertyName: propertyName),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0E7),
      body: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isBot = !msg.isUser;
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: msg.isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (isBot)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Image.asset(
                            'web/assets/wizard.png',
                            height: 32,
                          ),
                        ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? Colors.indigo
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color: msg.isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (_getSuggestions().isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                children: _getSuggestions()
                    .map(
                      (s) => ActionChip(
                        label: Text(s),
                        onPressed: () => _handleMessageSend(s),
                      ),
                    )
                    .toList(),
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
                      hintText: 'property details...',
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
    );
  }
}
