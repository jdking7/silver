import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';
import 'community_screen.dart';
import 'welfare_screen.dart';
import 'jobs_screen.dart';
import 'shopping_screen.dart';
import 'welfare_detail_screen.dart';
import 'ai_health_check_screen.dart';
import 'my_page_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('온고지신'),
        actions: [
          // Bell Icon with Red Dot
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 32),
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WelfareScreen()),
                  );
                },
                tooltip: '알림',
              ),
              Positioned(
                right: 12, // Adjusted for icon size
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          
          // My Page Icon
          IconButton(
            icon: const Icon(Icons.person, size: 32),
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyPageScreen()),
              );
            },
            tooltip: '마이페이지',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Greeting
              FutureBuilder<UserModel?>(
                future: DatabaseService().getUser(user?.uid ?? ''),
                builder: (context, snapshot) {
                  final displayName = snapshot.data?.displayName ?? user?.displayName ?? '어르신';
                  return Text(
                    '안녕하세요, $displayName님!',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              const SizedBox(height: 24),


              // 2. Welfare & AI Health Check (Split Row)
              SizedBox(
                height: 220, // Fixed height for consistency
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Left: Welfare News
                    Expanded(
                      child: _buildWelfareCard(context),
                    ),
                    const SizedBox(width: 16),
                    // Right: AI Health Check
                    Expanded(
                      child: _buildAIHealthCard(context),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // 3. Grid Menu
              LayoutBuilder(
                builder: (context, constraints) {
                  // Responsive: 2 columns on mobile, 4 on desktop/tablet
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.0, // Square tiles
                    children: [
                      _buildMenuTile(
                        context, 
                        icon: Icons.people_outline, 
                        label: '소통광장', 
                        color: const Color(0xFFFFB74D), // Light Orange
                        onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CommunityScreen()),
                          );
                        },
                      ),
                      _buildMenuTile(
                        context, 
                        icon: Icons.notifications_active_outlined, 
                        label: '복지알림', 
                        color: const Color(0xFF81C784), // Light Green
                        onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WelfareScreen()),
                          );
                        },
                      ),
                      _buildMenuTile(
                        context, 
                        icon: Icons.work_outline, 
                        label: '일자리', 
                        color: const Color(0xFF64B5F6), // Light Blue
                        onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const JobsScreen()),
                          );
                        },
                      ),
                      _buildMenuTile(
                        context, 
                        icon: Icons.shopping_basket_outlined, 
                        label: '쇼핑', 
                        color: const Color(0xFFBA68C8), // Light Purple
                        onTap: () {
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ShoppingScreen()),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelfareCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WelfareDetailScreen()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    '복지 소식',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(), // Push content to center
              const Center(
                child: Icon(Icons.newspaper, size: 50, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Text(
                '2024년 노인 일자리 모집',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              const Text(
                '지금 신청하세요!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAIHealthCard(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.blue.shade50, // Slightly distinctive background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AIHealthCheckScreen()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.monitor_heart, color: Colors.blue, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'AI 건강 체크',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Center(
                child: Icon(Icons.chat_bubble_outline, size: 50, color: Colors.blue),
              ),
              const SizedBox(height: 12),
              const Text(
                '어디 불편하세요?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              const Text(
                'AI와 상담하기',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 60, color: color.withOpacity(0.9)), // Large Icon
              ),
              const SizedBox(height: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 24, // Large text
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
