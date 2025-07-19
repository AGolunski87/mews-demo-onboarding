import 'package:flutter/material.dart';
import '../../models/ai_message.dart';

class ChatMessage extends StatelessWidget {
  final AiMessage message;
  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isBot = !message.isUser;
    return Align(
      alignment:
          message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                color: message.isUser ? Colors.indigo : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
