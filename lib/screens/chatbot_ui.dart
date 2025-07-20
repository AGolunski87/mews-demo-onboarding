import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/chat_controller.dart';
import '../services/onboarding_step.dart';
import '../models/property_details.dart';
import '../models/room_type.dart';
import 'demo_dashboard.dart';
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
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  final ChatController chatController = ChatController();
  final List<AiMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add(AiMessage.ai(chatController.prompt));
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
      _focusNode.requestFocus();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
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
              "assets/building.json",
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
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 72,
        leadingWidth: 180,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/logo/wizard.png',
            height: 100,
            fit: BoxFit.fitHeight,
          ),
        ),
        title: const Text(
          'Onboarding Wizard',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Colors.grey),
        ),
      ),
      body: Row(
        children: [
          // Left Panel — Chat area
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Lottie.asset('assets/bot.json', height: 100),
                const SizedBox(height: 8),
                const Text(
                  "Onboarding Wizard",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return ChatMessage(message: msg);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
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

          // Right Panel — Summary & Room Drawer
          Container(
            width: 360,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(left: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  child: Text(
                    chatController.getReadableSummary(),
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: RoomTypeDrawer(
                    numberOfRoomTypes: chatController.totalRoomTypes ?? 4,
                    summaryText: '',
                    onFinish: (List<RoomType> roomTypes) {
                      chatController.setRoomTypes(roomTypes);
                      chatController.saveResponse('done');
                      chatController.finalizeSetup();

                      final summary = chatController.getReadableSummary();
                      final details = chatController.buildPropertyDetails();

                      setState(() {
                        _messages.add(AiMessage.user("✅ Room setup complete"));
                        _messages.add(
                          AiMessage.ai(
                            "📝 Here's your property summary:\n\n$summary",
                          ),
                        );

                        final alreadyCalled = _messages.any(
                          (m) =>
                              m.isFunctionCall &&
                              m.functionName == 'generateDemo',
                        );

                        if (!alreadyCalled) {
                          _messages.add(
                            AiMessage.functionCall(
                              functionName: "generateDemo",
                              arguments: details.toJson().toString(),
                            ),
                          );
                          _showScrollDialog(context);
                        }

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
