import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WelfareDetailScreen extends StatelessWidget {
  const WelfareDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('복지 소식 상세')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.image, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              '2024년 노인 일자리 사업 참여자 모집 안내',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '모집중',
                    style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                const Text('조회수 1,240', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(height: 48, thickness: 1),
            const Text(
              '안녕하세요. 어르신들의 활기차고 건강한 노후생활을 지원하기 위해 2024년 노인 일자리 및 사회활동 지원사업 참여자를 모집합니다.\n\n'
              '■ 모집 기간: 2024. 01. 25. ~ 2024. 02. 10.\n\n'
              '■ 신청 자격: 만 60세 ~ 65세 이상 어르신 (사업별로 상이)\n\n'
              '■ 활동 내용:\n'
              ' - 공익활동: 지역사회 봉사 등\n'
              ' - 사회서비스형: 취약계층 서비스 지원 등\n'
              ' - 시장형: 소규모 매장 운영 등\n\n'
              '■ 신청 방법:\n'
              ' - 거주지 행정복지센터 방문 접수\n'
              ' - 온라인 신청 (노인일자리 여기)\n\n'
              '상세한 내용은 가까운 구청 사회복지과로 문의해주시기 바랍니다.',
              style: TextStyle(fontSize: 20, height: 1.6),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              child: const Text('전화로 문의하기'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 65),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('공유하기', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
