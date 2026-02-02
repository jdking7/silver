import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AIHealthCheckScreen extends StatefulWidget {
  const AIHealthCheckScreen({super.key});

  @override
  State<AIHealthCheckScreen> createState() => _AIHealthCheckScreenState();
}

class _AIHealthCheckScreenState extends State<AIHealthCheckScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Start with the initial question
    _addMessage("AI", "안녕하세요, 김어르신님.\n어디 불편하신 곳이 있으신가요?");
  }

  void _addMessage(String sender, String text) {
    setState(() {
      _messages.add({"sender": sender, "text": text});
    });
    // Scroll to bottom after frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    _addMessage("User", text);

    // Mock AI Response
    Future.delayed(const Duration(seconds: 1), () {
      _addMessage("AI", "저런, 많이 불편하시겠어요.\n증상이 지속되면 꼭 병원을 방문해보시는 게 좋겠어요.\n더 자세한 증상을 말씀해 주시겠어요?");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 건강 체크'),
      ),
      body: Column(
        children: [
          // Chat Area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'User';
                return _buildMessageBubble(
                  message['text']!,
                  isUser,
                );
              },
            ),
          ),
          
          // Disclaimer
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.amber.shade50,
            width: double.infinity,
            child: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "이 대화는 의학적 진단이 아닙니다.\n꼭 의사와 상담하세요.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.brown),
                  ),
                ),
              ],
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: '증상을 입력해주세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? AppTheme.primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(0),
            bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
