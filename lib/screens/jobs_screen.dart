import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일자리')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildJobItem(
            context,
            title: '[실버] 아파트 단지 보안 요원 모집',
            company: '그린보안공사',
            salary: '월 220만원',
            location: '서울시 강남구',
          ),
          _buildJobItem(
            context,
            title: '시니어 도서관 보조원 대모집',
            company: '푸른도서관',
            salary: '시급 11,000원',
            location: '경기도 수원시',
          ),
          _buildJobItem(
            context,
            title: '전통시장 도우미 (오전 알바)',
            company: '시장번영회',
            salary: '일 5만원',
            location: '광주광역시 남구',
          ),
        ],
      ),
    );
  }

  Widget _buildJobItem(BuildContext context, {required String title, required String company, required String salary, required String location}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
            const SizedBox(height: 8),
            Text(company, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 20, color: Colors.grey),
                const SizedBox(width: 4),
                Text(location, style: const TextStyle(fontSize: 18, color: Colors.grey)),
                const Spacer(),
                Text(salary, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text('지원하기'),
            ),
          ],
        ),
      ),
    );
  }
}
