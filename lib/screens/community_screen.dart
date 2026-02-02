import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';
import '../theme/app_theme.dart';
import 'post_detail_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for fallback
    final List<Post> dummyPosts = [
      Post(
        postId: '1',
        category: '건강',
        title: '겨울철 무릎 관절 관리법',
        content: '겨울철에는 기온이 낮아져 무릎 관술이 굳기 쉽습니다. 집에서 할 수 있는 간단한 스트레칭 방법을 소개합니다...',
        imageUrl: '',
        timestamp: DateTime.now(),
        authorName: '박의사',
      ),
      Post(
        postId: '2',
        category: 'AI',
        title: '스마트폰으로 손녀와 영상통화 하는 법',
        content: '카카오톡 영상통화 기능을 활용해서 멀리 있는 가족들과 얼굴을 보며 대화해보세요. 생각보다 아주 쉽습니다.',
        imageUrl: '',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        authorName: 'IT봉사단',
      ),
      Post(
        postId: '3',
        category: '나눔',
        title: '동네 정자 근처에서 장기를 두실 분 찾습니다',
        content: '매일 오후 2시쯤 동네 정자에서 기다리고 있겠습니다. 실력에 상관없이 즐겁게 두실 분 환영합니다.',
        imageUrl: '',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        authorName: '이동네',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('소통광장'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (() {
          try {
            return FirebaseFirestore.instance
                .collection('posts')
                .orderBy('timestamp', descending: true)
                .snapshots();
          } catch (e) {
            // Return empty stream on error
            return const Stream<QuerySnapshot>.empty();
          }
        })(),
        builder: (context, snapshot) {
          List<Post> postsToDisplay = [];

          if (snapshot.hasData && snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
            postsToDisplay = snapshot.data!.docs.map((doc) => Post.fromFirestore(doc)).toList();
          } else {
            // Show dummy data if loading, empty, or error
            postsToDisplay = dummyPosts;
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: postsToDisplay.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return _buildPostCard(context, postsToDisplay[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement Write Post Screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('글쓰기 기능은 준비 중입니다.')),
          );
        },
        label: const Text('글쓰기', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.edit, size: 28),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Post post) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category & Time
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      post.category,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    DateFormat('yyyy-MM-dd').format(post.timestamp),
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Title and Image Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post.authorName,
                          style: const TextStyle(fontSize: 18, color: AppTheme.textSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                  if (post.imageUrl != null && post.imageUrl!.isNotEmpty) ...[
                    const SizedBox(width: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        post.imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const SizedBox(),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
