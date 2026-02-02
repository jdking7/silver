import 'package:flutter/material.dart';

class WelfareScreen extends StatelessWidget {
  const WelfareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('복지알림')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildWelfareItem(
            context,
            title: '2024년 고령자 고용지원금 신청 안내',
            date: '2024-01-20',
            description: '60세 이상 고령자를 고용한 사업주에게 지원금을 드립니다.',
          ),
          _buildWelfareItem(
            context,
            title: '무료 건강검진 바우처 발급 안내',
            date: '2024-01-18',
            description: '가까운 보건소에서 혈압, 당뇨 등 기초 검진을 무료로 받으세요.',
          ),
          _buildWelfareItem(
            context,
            title: '경로당 난방비 지원 사업',
            date: '2024-01-15',
            description: '겨울철 따뜻한 휴식을 위해 난방비를 추가 지원합니다.',
          ),
        ],
      ),
    );
  }

  Widget _buildWelfareItem(BuildContext context, {required String title, required String date, required String description}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(date, style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 12),
            Text(description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('상세보기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
