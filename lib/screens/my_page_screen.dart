import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../models/user_model.dart';
import 'login_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 로그인 상태 확인
    final user = FirebaseAuth.instance.currentUser;

    // 로그인 안 되어 있으면 로그인 화면으로 이동
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
      
      // 로딩 화면 표시
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 로그인되어 있으면 마이페이지 표시
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        actions: [
          // 로그아웃 버튼
          IconButton(
            icon: const Icon(Icons.logout, size: 28),
            onPressed: () async {
              // 로그아웃 확인 다이얼로그
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('로그아웃', style: TextStyle(fontSize: 22)),
                  content: const Text(
                    '로그아웃 하시겠습니까?',
                    style: TextStyle(fontSize: 20),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('취소', style: TextStyle(fontSize: 20)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('로그아웃', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true && context.mounted) {
                await AuthService().signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Section
            // 1. 프로필 섹션 (Firestore 데이터 연동)
            FutureBuilder<UserModel?>(
              future: DatabaseService().getUser(user.uid),
              builder: (context, snapshot) {
                final String displayName = snapshot.data?.displayName ?? user.displayName ?? '사용자';
                final String email = user.email!;
                final int? birthYear = snapshot.data?.birthYear;

                return Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                        child: Icon(Icons.person, size: 60, color: AppTheme.primaryColor),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        displayName,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      if (birthYear != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          '${DateTime.now().year - birthYear + 1}세 ($birthYear년생)',
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '오늘도 건강한 하루 되세요!',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // Health Info Section
            _buildInfoCard(
              context,
              title: "건강검진일",
              icon: Icons.calendar_month,
              content: "2024년 10월 15일",
              color: Colors.blue.shade100,
            ),
            const SizedBox(height: 16),
            
            // Daycare Info Section
            _buildInfoCard(
              context,
              title: "데이케어센터",
              icon: Icons.store,
              content: "행복한 데이케어 센터\n(02-1234-5678)",
              color: Colors.orange.shade100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required String title, required IconData icon, required String content, required Color color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: Colors.black54),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
