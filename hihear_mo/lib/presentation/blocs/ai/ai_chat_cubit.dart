import 'package:bloc/bloc.dart';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/domain/usecases/get_ai_response.dart';
import 'package:hihear_mo/presentation/pages/HearuAi/ai_chat_page.dart';

part 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final GetAiResponse getAiResponse;

  AiChatCubit(this.getAiResponse) : super(AiChatInitial(messages: []));

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    final currentMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: userMessage, isUser: true, timestamp: DateTime.now()));

    emit(AiChatLoading(messages: currentMessages));

    try {
      final aiText = await getAiResponse(userMessage, currentMessages);
      final updatedMessages = List<ChatMessage>.from(currentMessages)
        ..add(ChatMessage(text: aiText, isUser: false, timestamp: DateTime.now()));
      emit(AiChatLoaded(messages: updatedMessages));
    } catch (e) {
      emit(AiChatError(messages: currentMessages, error: e.toString()));
    }
  }
}
