
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/presentation/pages/HearuAi/ai_chat_page.dart';

abstract class AiChatRepository {
  Future<String> getAiResponse(String userMessage, List<ChatMessage> history);
}
