import 'package:get/get.dart';
import '../services/ai_service.dart';

class FlashcardController extends GetxController {
  final AiService _aiService = AiService();

  var messages = <Map<String, String>>[].obs;
  // Loading state
  var isLoading = false.obs;

  // Error message
  var errorMessage = ''.obs;

  Future<void> sendMessage(String question) async {
    if (question.trim().isEmpty) return;
    messages.add({
      "role": "user",
      "content": question,
    });

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _aiService.getAnswer(messages);
      messages.add({
        "role": "assistant",
        "content": result,
      });
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void clearChat() {
    messages.clear();
    errorMessage.value = '';
  }
}