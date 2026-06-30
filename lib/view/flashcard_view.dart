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
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6C63FF), Color(0xFF8B84FF)],
            ),
          ),
        ),
        toolbarHeight: 70,
        elevation: 10,
        shadowColor: Colors.black26,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Text(
              'StudyAI',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 28),
              onPressed: () => controller.clearChat(),
              tooltip: 'Clear Chat',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Chat Messages ──
          Expanded(
            child: Obx(() {
              if (controller.messages.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 80, color: Color(0xFF6C63FF)),
                      SizedBox(height: 16),
                      Text(
                        'Ask me anything!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Scrollbar(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final messageIndex = controller.messages.length - 1 - index;
                    final message = controller.messages[messageIndex];
                    final isUser = message['role'] == 'user';
                    return _MessageBubble(
                      message: message['content'] ?? '',
                      isUser: isUser,
                    );
                  },
                ),
              );
            }),
          ),

          // ── Loading Indicator ──
          Obx(() => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('AI is thinking...',
                      style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic)),
                )
              : const SizedBox()),

          // ── Error Message ──
          Obx(() => controller.errorMessage.value.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  color: Colors.red.shade50,
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                )
              : const SizedBox()),

          // ── Input Area ──
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      maxLines: 4,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Ask me anything...',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF5F6FA),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() => CircleAvatar(
                        radius: 26,
                        backgroundColor: controller.isLoading.value
                            ? Colors.grey.shade300
                            : const Color(0xFF6C63FF),
                        child: IconButton(
                          icon: const Icon(Icons.send_rounded,
                              color: Colors.white, size: 24),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  final text = textController.text.trim();
                                  if (text.isEmpty) return;
                                  controller.sendMessage(text);
                                  textController.clear();
                                },
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const _MessageBubble({
    required this.message,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF6C63FF) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: message));
            Get.snackbar(
              'Copied!',
              'Message copied to clipboard',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.black87,
              colorText: Colors.white,
              margin: const EdgeInsets.all(15),
              borderRadius: 10,
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              message,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
