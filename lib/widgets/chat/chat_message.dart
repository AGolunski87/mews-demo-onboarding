import 'package:flutter/material.dart';
import '../../models/ai_message.dart';

class ChatMessage extends StatelessWidget {
  final AiMessage message;
  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isBot = !message.isUser;

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (isBot)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset('web/assets/wizard.png', height: 32),
            ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.indigo : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (message.isFunctionCall) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildLinkChip(context, "Booking", "/booking"),
                        _buildLinkChip(context, "Front Desk", "/front-desk"),
                        _buildLinkChip(
                          context,
                          "Housekeeping",
                          "/housekeeping",
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkChip(BuildContext context, String label, String route) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}
