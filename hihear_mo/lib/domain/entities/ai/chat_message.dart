enum AiActionType {
  none,
  navigateToNextLesson,
  changeUserName,
}
class AiActionResponse {
  final String text;
  final AiActionType actionType;
  final Map<String, dynamic>? actionData;

  AiActionResponse({
    required this.text,
    this.actionType = AiActionType.none,
    this.actionData,
  });

  factory AiActionResponse.fromJson(Map<String, dynamic> json) {
    return AiActionResponse(
      text: json['text'] as String,
      actionType: _parseActionType(json['action'] as String?),
      actionData: json['actionData'] as Map<String, dynamic>?,
    );
  }

  static AiActionType _parseActionType(String? action) {
    switch (action?.toLowerCase()) {
      case 'navigate_next_lesson':
        return AiActionType.navigateToNextLesson;
      case 'change_user_name':
        return AiActionType.changeUserName;
      default:
        return AiActionType.none;
    }
  }

  bool get hasAction => actionType != AiActionType.none;
}

// ==================== CHAT MESSAGE UPDATE ====================

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final AiActionResponse? actionResponse;
  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.actionResponse,
  });

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    AiActionResponse? actionResponse,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      actionResponse: actionResponse ?? this.actionResponse,
    );
  }
}