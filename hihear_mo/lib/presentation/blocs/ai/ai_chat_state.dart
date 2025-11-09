part of 'ai_chat_cubit.dart';

abstract class AiChatState {
  final List<ChatMessage> messages;
  AiChatState({required this.messages});
}

class AiChatInitial extends AiChatState {
  AiChatInitial({required List<ChatMessage> messages}) : super(messages: messages);
}

class AiChatLoading extends AiChatState {
  AiChatLoading({required List<ChatMessage> messages}) : super(messages: messages);
}

class AiChatLoaded extends AiChatState {
  AiChatLoaded({required List<ChatMessage> messages}) : super(messages: messages);
}

class AiChatError extends AiChatState {
  final String error;
  AiChatError({required List<ChatMessage> messages, required this.error}) : super(messages: messages);
}
