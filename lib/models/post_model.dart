import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String category;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final String authorName;

  Post({
    required this.postId,
    required this.category,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    required this.authorName,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Post(
      postId: doc.id,
      category: data['category'] ?? '일반',
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      authorName: data['authorName'] ?? '익명',
    );
  }
}
