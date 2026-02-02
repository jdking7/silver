import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';
import '../theme/app_theme.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.category),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              post.title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Meta info
            Row(
              children: [
                Text(
                  post.authorName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm').format(post.createdAt),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1),

            // Content
            Text(
              post.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8, // Better readability for seniors
              ),
            ),
            const SizedBox(height: 40),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.thumb_up_alt_outlined, "공감 ${post.likesCount}", () {
                  // TODO: 좋아요 기능 구현
                }),
                _buildActionButton(Icons.comment_outlined, "댓글달기", () {
                  // TODO: 댓글 흐름 구현
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('댓글 기능은 준비 중입니다.')),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 28),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 56), 
      ),
    );
  }
}
