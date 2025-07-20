class AiMessage {
  final String? text;
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

  AiMessage.functionCall({required this.functionName, required this.arguments})
      : isUser = false,
        isFunctionCall = true,
        text = "\u{1FAA3} Casting scroll spell...";
}
