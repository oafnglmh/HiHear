import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/presentation/pages/HearuAi/ai_chat_page.dart';

import '../repositories/ai_chat_repository.dart';

class GetAiResponse {
  final AiChatRepository repository;

  GetAiResponse(this.repository);

  Future<String> call(String message, List<ChatMessage> history) async {
    return await repository.getAiResponse(message, history);
  }
}
