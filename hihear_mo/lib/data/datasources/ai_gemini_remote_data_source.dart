import 'dart:convert';
import 'package:hihear_mo/domain/entities/ai/chat_message.dart';
import 'package:http/http.dart' as http;

class AiRemoteDataSource {
  final String apiKey;
  final String apiUrl;

  AiRemoteDataSource({required this.apiKey, required this.apiUrl});

  Future<Map<String, dynamic>> fetchResponseWithAction(
    String message,
    String conversationHistory,
  ) async {
    final response = await http.post(
      Uri.parse('$apiUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': conversationHistory},
            ],
          },
        ],
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 800,
          'topP': 0.8,
          'topK': 40,
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final rawText =
          data['candidates'][0]['content']['parts'][0]['text'] as String;

      return _parseAiResponse(rawText);
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }

  Map<String, dynamic> _parseAiResponse(String rawText) {
    final actionRegex = RegExp(r'<ACTION:(.*?)>(.*?)</ACTION>', dotAll: true);
    final match = actionRegex.firstMatch(rawText);

    if (match != null) {
      final actionPart = match.group(1)!;
      final textPart = match.group(2)!.trim();

      final actionParts = actionPart.split('|');
      final actionType = actionParts[0];
      final actionData = actionParts.length > 1
          ? _parseActionData(actionParts[1])
          : null;

      return {'text': textPart, 'action': actionType, 'actionData': actionData};
    }

    return {'text': rawText, 'action': null, 'actionData': null};
  }

  Map<String, dynamic>? _parseActionData(String dataString) {
    try {
      return jsonDecode(dataString) as Map<String, dynamic>;
    } catch (e) {
      print('Error parsing action data: $e');
      return null;
    }
  }
}


class AiPromptBuilder {
  static String buildSystemPrompt(
    List<ChatMessage> history,
    String currentMessage,
  ) {
    final buffer = StringBuffer();

    buffer.writeln("""
# SYSTEM PROMPT - AI TRỢ GIẢNG TIẾNG VIỆT

## NHIỆM VỤ CHÍNH
Bạn là AI trợ giảng tiếng Việt thông minh, có khả năng:
1. Trò chuyện hài hước, dí dỏm
2. **QUAN TRỌNG: NHẬN DIỆN VÀ THỰC THI HÀNH ĐỘNG**
3. Hướng dẫn học viên một cách nhẹ nhàng

## CÚ PHÁP HÀNH ĐỘNG (ACTION SYNTAX)
Khi học viên yêu cầu thực hiện một hành động, bạn PHẢI trả về theo format:

<ACTION:action_type|{json_data}>Phản hồi văn bản của bạn ở đây</ACTION>

### DANH SÁCH HÀNH ĐỘNG:

1. **CHUYỂN ĐẾN BÀI HỌC TIẾP THEO**
   - Trigger: "bài tiếp theo", "next lesson", "học tiếp"
   - Format: <ACTION:navigate_next_lesson>Đang chuyển bạn đến bài học tiếp theo nhé! 🚀</ACTION>

2. **ĐỔI TÊN NGƯỜI DÙNG**
   - Trigger: "đổi tên", "change name", "tên tôi là"
   - Format: <ACTION:change_user_name|{"newName":"Tên mới"}>Bạn muốn đổi tên thành "[Tên]" đúng không? Để mình xác nhận nhé! 📝</ACTION>

## VÍ DỤ TƯƠNG TÁC:

### Ví dụ 1: Đổi tên
**Học viên:** "Tôi muốn đổi tên thành Minh Anh"
**AI:** <ACTION:change_user_name|{"newName":"Minh Anh"}>Ồ, "Minh Anh" là tên đẹp đấy! 😊 Bạn có chắc muốn đổi tên không? Mình sẽ cập nhật ngay!</ACTION>

### Ví dụ 2: Bài học tiếp theo
**Học viên:** "Đưa tôi đến bài học tiếp theo"
**AI:** <ACTION:navigate_next_lesson>Okela! Bài tiếp theo đang chờ bạn rồi đấy! Cùng mình khám phá nhé! 🚀</ACTION>

### Ví dụ 3: Chỉ chat thường
**Học viên:** "Hôm nay thế nào?"
**AI:** Hôm nay mình khỏe lắm! Còn bạn? Có muốn học gì không? 😄

## LƯU Ý QUAN TRỌNG:
- Luôn phản hồi thân thiện, hài hước
- NẾU có action → BẮT BUỘC dùng cú pháp <ACTION>
- NẾU chỉ chat → Không cần tag <ACTION>
- Không tự ý đoán action nếu không chắc chắn
- Xác nhận lại với học viên trước khi thực hiện action quan trọng

---
## LỊCH SỬ HỘI THOẠI:
""");

    for (var msg in history) {
      buffer.writeln('${msg.isUser ? "Học viên" : "AI"}: ${msg.text}');
    }

    buffer.writeln('\nHọc viên: $currentMessage');
    buffer.writeln('AI: ');

    return buffer.toString();
  }
}
