import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/database_service.dart';
import '../models/post_model.dart';
import '../theme/app_theme.dart';

class WritePostScreen extends StatefulWidget {
  const WritePostScreen({super.key});

  @override
  State<WritePostScreen> createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  
  String _selectedCategory = '일상';
  bool _isLoading = false;

  final List<String> _categories = ['일상', '건강', '질문', '정보'];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) return;
    
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인이 필요합니다.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 작성자 이름 가져오기 (Auth 프로필 우선, 없으면 Firestore 조회)
      String authorName = user.displayName ?? '';
      
      if (authorName.isEmpty || authorName == '어르신') {
        final userModel = await DatabaseService().getUser(user.uid);
        if (userModel != null && userModel.displayName.isNotEmpty) {
          authorName = userModel.displayName;
        } else {
          authorName = '익명';
        }
      }

      final newPost = PostModel(
        id: '', // Firestore에서 자동 생성
        authorId: user.uid,
        authorName: authorName,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _selectedCategory,
        createdAt: DateTime.now(),
      );

      await DatabaseService().createPost(newPost);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('게시글이 등록되었습니다!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // 목록 화면으로 복귀
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('등록 실패: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('글쓰기'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submitPost,
            child: _isLoading 
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('완료', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 카테고리 선택
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedCategory = value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 제목 입력
              TextFormField(
                controller: _titleController,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: '제목을 입력하세요',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) => 
                  value == null || value.isEmpty ? '제목을 입력해주세요' : null,
              ),
              const Divider(thickness: 1),

              // 내용 입력
              TextFormField(
                controller: _contentController,
                style: const TextStyle(fontSize: 18, height: 1.5),
                maxLines: 15,
                decoration: const InputDecoration(
                  hintText: '내용을 자유롭게 작성해주세요.\n예: 오늘 점심은 뭘 드셨나요?',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) => 
                  value == null || value.isEmpty ? '내용을 입력해주세요' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
