import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'community_screen.dart';
import 'welfare_screen.dart';
import 'jobs_screen.dart';
import 'shopping_screen.dart';
import 'welfare_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('온고지신'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 36), // Large icon
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelfareScreen()),
              );
            },
            tooltip: '알림',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Greeting
              Text(
                '안녕하세요, 김어르신님!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),

              // 2. Today's Welfare News (Large Card)
              _buildWelfareCard(context),
              
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WelfareDetailScreen()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 30),
                  const SizedBox(width: 8),
                  Text(
                    '오늘의 복지 소식',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  // image: DecorationImage(...) // TODO: Add real image
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.image, size: 60, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                '2024년 노인 일자리 사업 참여자 모집 안내',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              const Text(
                '신청 기간: 1월 25일 ~ 2월 10일까지\n가까운 행정복지센터에서 신청하세요.',
                style: TextStyle(fontSize: 18),
              ),
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
