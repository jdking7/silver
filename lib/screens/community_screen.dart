import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';
import '../theme/app_theme.dart';
import 'post_detail_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _selectedCategory = '전체';
  final List<String> _categories = ['전체', '생활의 팁', '건강', '여행', '모임', '데이케어센터', 'AI', '나눔'];

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
      Post(
        postId: '4',
        category: '생활의 팁',
        title: '전기요금 절약하는 꿀팁 5가지',
        content: '사용하지 않는 플러그 뽑기, 냉장고 적정 온도 유지하기 등 생활 속 작은 실천으로...',
        imageUrl: '',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        authorName: '알뜰살림',
      ),
      Post(
        postId: '5',
        category: '여행',
        title: '봄꽃 구경하기 좋은 서울 근교 명소',
        content: '가볍게 다녀오기 좋은 봄꽃 명소를 추천해 드립니다. 대중교통으로도 쉽게 갈 수 있어요.',
        imageUrl: '',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        authorName: '여행지기',
      ),
       Post(
        postId: '6',
        category: '데이케어센터',
        title: '우리 동네 데이케어센터 체험기',
        content: '처음 가봤는데 프로그램도 다양하고 식사도 맛있네요. 추천합니다.',
        imageUrl: '',
        timestamp: DateTime.now().subtract(const Duration(days: 4)),
        authorName: '김어르신',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('소통광장'),
      ),
      body: Column(
        children: [
          // Category Chips
          SizedBox(
            height: 60,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return ChoiceChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: AppTheme.primaryColor,
                  backgroundColor: Colors.white,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    }
                  },
                );
              },
            ),
          ),
          
          // Post List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (() {
                try {
                  Query query = FirebaseFirestore.instance.collection('posts');
                  
                  // Filter by category if not '전체'
                  if (_selectedCategory != '전체') {
                    query = query.where('category', isEqualTo: _selectedCategory);
                  }

                  return query
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
                  // Apply local filtering to dummy data
                  if (_selectedCategory == '전체') {
                     postsToDisplay = dummyPosts;
                  } else {
                    postsToDisplay = dummyPosts.where((post) => post.category == _selectedCategory).toList();
                  }
                }

                if (postsToDisplay.isEmpty) {
                  return const Center(
                    child: Text('게시글이 없습니다.', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  );
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
          ),
        ],
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
