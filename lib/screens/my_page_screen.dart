import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '김어르신 님',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '오늘도 건강한 하루 되세요!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
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
