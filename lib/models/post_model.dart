import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String authorId;
  final String authorName;
  final String title;
  final String content;
  final String category; // '일상', '건강', '질문' 등
  final DateTime createdAt;
  final int likesCount;
  final List<String> likedBy; // 좋아요 누른 사용자 ID 목록

  PostModel({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    this.likesCount = 0,
    this.likedBy = const [],
  });

  factory PostModel.fromMap(Map<String, dynamic> map, String id) {
    return PostModel(
      id: id,
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '익명',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? '일상',
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
      likesCount: map['likesCount'] ?? 0,
      likedBy: List<String>.from(map['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'title': title,
      'content': content,
      'category': category,
      'createdAt': createdAt,
      'likesCount': likesCount,
      'likedBy': likedBy,
    };
  }

  PostModel copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? title,
    String? content,
    String? category,
    DateTime? createdAt,
    int? likesCount,
    List<String>? likedBy,
  }) {
    return PostModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      likedBy: likedBy ?? this.likedBy,
    );
  }
}
