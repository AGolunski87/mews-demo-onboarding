import 'package:flutter/material.dart';

class AiMessage {
  final String? text;
  final bool isUser;
  final bool isFunctionCall;
  final String? functionName;
  final String? arguments;
  final Widget? child;

  AiMessage.user(this.text)
    : isUser = true,
      isFunctionCall = false,
      functionName = null,
      arguments = null,
      child = null;

  AiMessage.ai(this.text)
    : isUser = false,
      isFunctionCall = false,
      functionName = null,
      arguments = null,
      child = null;

  AiMessage.system(this.text)
    : isUser = false,
      isFunctionCall = false,
      functionName = null,
      arguments = null,
      child = null;

  AiMessage.functionCall({required this.functionName, required this.arguments})
    : isUser = false,
      isFunctionCall = true,
      text = "\u{1FAA3} Casting scroll spell...",
      child = null;

  /// ✅ Custom widget message (e.g. buttons)
  AiMessage.custom(this.child)
    : isUser = false,
      isFunctionCall = false,
      text = null,
      functionName = null,
      arguments = null;
}
