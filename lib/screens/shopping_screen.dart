import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('쇼핑')),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.7,
        children: [
          _buildShopItem('명품 영양제 세트', '45,000원', Icons.medical_services_outlined),
          _buildShopItem('편안한 효도 신발', '39,000원', Icons.directions_walk),
          _buildShopItem('유기농 잡곡 5kg', '28,000원', Icons.grass),
          _buildShopItem('따뜻한 내복 세트', '15,000원', Icons.checkroom),
        ],
      ),
    );
  }

  Widget _buildShopItem(String name, String price, IconData icon) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: Icon(icon, size: 80, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(fontSize: 20, color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
