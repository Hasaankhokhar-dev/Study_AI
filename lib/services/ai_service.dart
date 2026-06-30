import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class AiService {
  final String _apiKey = dotenv.env['OPENROUTER_API_KEY'] ?? '';
  final String _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';

  Future<String> getAnswer(List<Map<String, String>> messages) async {
    final url = Uri.parse(_baseUrl);

    final body = jsonEncode({
      "model": "cohere/north-mini-code:free",
      "messages": messages,
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }
}