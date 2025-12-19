import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:hihear_mo/domain/usecases/get_ai_response.dart';

part 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final GetAiResponse getAiResponse;

  AiChatCubit(this.getAiResponse) : super(AiChatInitial(messages: [])) {
    developer.log('AiChatCubit initialized', name: 'AI_CHAT');
  }

  Future<void> sendMessage(String userMessage) async {
    final trimmedMessage = userMessage.trim();
    if (trimmedMessage.isEmpty) {
      developer.log('sendMessage: Tin nhắn rỗng, bỏ qua', name: 'AI_CHAT');
      return;
    }

    developer.log('sendMessage: Người dùng gửi: "$trimmedMessage"', name: 'AI_CHAT');
    final currentMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(
        text: trimmedMessage,
        isUser: true,
        timestamp: DateTime.now(),
      ));

    developer.log('Emit AiChatLoading với ${currentMessages.length} tin nhắn', name: 'AI_CHAT');
    emit(AiChatLoading(messages: currentMessages));

    try {
      developer.log('Bắt đầu gọi GetAiResponse...', name: 'AI_CHAT');
      final aiText = await getAiResponse(trimmedMessage, currentMessages);

      developer.log('Nhận phản hồi từ AI thành công (độ dài: ${aiText.length} ký tự)', name: 'AI_CHAT');
      if (aiText.trim().isEmpty) {
        throw Exception('Phản hồi từ Gemini rỗng');
      }

      final updatedMessages = List<ChatMessage>.from(currentMessages)
        ..add(ChatMessage(
          text: aiText,
          isUser: false,
          timestamp: DateTime.now(),
        ));

      developer.log('Emit AiChatLoaded với ${updatedMessages.length} tin nhắn', name: 'AI_CHAT');
      emit(AiChatLoaded(messages: updatedMessages));
    } catch (e, stackTrace) {
      developer.log(
        'LỖI khi gọi Gemini API: $e',
        name: 'AI_CHAT',
        error: e,
        stackTrace: stackTrace,
      );
      emit(AiChatError(
        messages: currentMessages,
        error: _formatErrorMessage(e),
      ));
    }
  }
  String _formatErrorMessage(dynamic error) {
    if (error.toString().contains('403')) {
      return 'Lỗi quyền truy cập API (403). Có thể API key bị vô hiệu hóa hoặc bị giới hạn.';
    }
    if (error.toString().contains('404')) {
      return 'Không tìm thấy model Gemini. Kiểm tra tên model trong URL.';
    }
    if (error.toString().contains('400')) {
      return 'Yêu cầu không hợp lệ (400). Kiểm tra định dạng request.';
    }
    if (error.toString().contains('429')) {
      return 'Quá nhiều yêu cầu (rate limit). Chờ một chút rồi thử lại.';
    }
    if (error.toString().contains('500') || error.toString().contains('503')) {
      return 'Lỗi server Google (500/503). Thử lại sau vài phút.';
    }
    return 'Lỗi kết nối với AI: $error';
  }

  @override
  void onChange(Change<AiChatState> change) {
    super.onChange(change);
    developer.log(
      'State change: ${change.currentState.runtimeType} → ${change.nextState.runtimeType}',
      name: 'AI_CHAT',
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    developer.log('Cubit error: $error', name: 'AI_CHAT', error: error, stackTrace: stackTrace);
  }
}