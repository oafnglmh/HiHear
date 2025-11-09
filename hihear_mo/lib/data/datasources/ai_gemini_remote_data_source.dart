import 'dart:convert';
import 'package:http/http.dart' as http;

class AiRemoteDataSource {
  final String apiKey;
  final String apiUrl;

  AiRemoteDataSource({required this.apiKey, required this.apiUrl});

  Future<String> fetchResponse(String message, String conversationHistory) async {
    final response = await http.post(
      Uri.parse('$apiUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {'parts': [{'text': conversationHistory}]}
        ],
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 500,
          'topP': 0.8,
          'topK': 40,
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['candidates'][0]['content']['parts'][0]['text'] as String;
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }
}
