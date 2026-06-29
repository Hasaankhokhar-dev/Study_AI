import 'package:get/get.dart';
import '../services/ai_service.dart';

class FlashcardController extends GetxController {
  final AiService _aiService = AiService();

  // AI ka response store karo
  RxString answer = ''.obs;

  // Loading state
  RxBool isLoading = false.obs;

  // Error message
  RxString errorMessage = ''.obs;

  Future<void> getAnswer(String question) async {
    if (question.trim().isEmpty) {
      errorMessage.value = 'Please enter a question.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    answer.value = '';

    try {
      final result = await _aiService.getAnswer(question);
      answer.value = result;
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}