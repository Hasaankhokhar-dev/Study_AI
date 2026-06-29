import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/flashcard_controller.dart';

class FlashcardView extends StatelessWidget {
  FlashcardView({super.key});

  final FlashcardController controller = Get.put(FlashcardController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyAI'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ── Question Input ──
            TextField(
              controller: textController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Enter your question...',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // ── Ask Button ──
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.getAnswer(textController.text),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Ask AI'),
              )),
            ),

            const SizedBox(height: 16),

            // ── Error Message ──
            Obx(() => controller.errorMessage.value.isNotEmpty
                ? Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            )
                : const SizedBox()),

            // ── AI Response ──
            Expanded(
              child: Obx(() => controller.answer.value.isEmpty
                  ? const Center(
                child: Text(
                  'Ask a question to get started.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Copy Button ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'AI Response:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 20),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: controller.answer.value));
                            Get.snackbar(
                              'Copied!',
                              'Response copied to clipboard.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          },
                        ),
                      ],
                    ),

                    const Divider(),

                    // ── Response Text (Scrollable + Selectable) ──
                    Expanded(
                      child: SingleChildScrollView(
                        child: SelectableText(
                          controller.answer.value,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ],

                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}