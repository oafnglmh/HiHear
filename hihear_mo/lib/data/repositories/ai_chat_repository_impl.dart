import 'package:hihear_mo/data/datasources/ai_gemini_remote_data_source.dart';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/presentation/pages/HearuAi/ai_chat_page.dart';

import '../../domain/repositories/ai_chat_repository.dart';


class AiChatRepositoryImpl implements AiChatRepository {
  final AiRemoteDataSource api;

  AiChatRepositoryImpl(this.api);

  @override
  Future<String> getAiResponse(String userMessage, List<ChatMessage> history) async {
    final conversationHistory = _buildConversationHistory(userMessage, history);
    return await api.fetchResponse(userMessage, conversationHistory);
  }

  String _buildConversationHistory(String currentMessage, List<ChatMessage> history) {
  final buffer = StringBuffer();

  buffer.writeln("Bạn là AI trợ giảng tiếng Việt. Bạn luôn:");
  buffer.writeln("- Hài hước, dí dỏm khi phản hồi.");
  buffer.writeln("- Nhẹ nhàng bắt lỗi học viên nếu họ sai, nhưng không làm họ xấu hổ.");
  buffer.writeln("- Giải thích lý do và đưa ví dụ vui vẻ khi cần.");

  for (var msg in history) {
    buffer.writeln('${msg.isUser ? "Học viên" : "AI Trợ Giảng"}: ${msg.text}');
  }

  buffer.writeln('Học viên: $currentMessage');

  buffer.writeln("AI Trợ Giảng: Hãy trả lời học viên theo phong cách trên.");

  return buffer.toString();
}

}
