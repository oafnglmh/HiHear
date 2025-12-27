import 'package:hihear_mo/domain/entities/ai/chat_message.dart';

abstract class AiChatRepository {
  Future<AiActionResponse> getAiResponse(String userMessage, List<ChatMessage> history);
}
