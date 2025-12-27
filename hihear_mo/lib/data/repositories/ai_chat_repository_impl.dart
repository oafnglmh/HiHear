import 'package:hihear_mo/data/datasources/ai_gemini_remote_data_source.dart';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/domain/repositories/ai_chat_repository.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiRemoteDataSource api;

  AiChatRepositoryImpl(this.api);

  @override
  Future<AiActionResponse> getAiResponse(String userMessage, List<ChatMessage> history) async {
    final conversationHistory = AiPromptBuilder.buildSystemPrompt(history, userMessage);
    final rawResponse = await api.fetchResponseWithAction(userMessage, conversationHistory);
    
    return AiActionResponse.fromJson(rawResponse);
  }
}