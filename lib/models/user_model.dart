class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final int birthYear;
  final String gender; // 'male', 'female', 'other'
  final String role; // 'user', 'admin'
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.birthYear,
    required this.gender,
    this.role = 'user',
    required this.createdAt,
  });

  // Firestore 데이터(Map)를 객체로 변환
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      photoUrl: map['photoUrl'],
      birthYear: map['birthYear'] ?? 0,
      gender: map['gender'] ?? 'other',
      role: map['role'] ?? 'user',
      createdAt: map['createdAt'] != null 
          ? (map['createdAt']).toDate() 
          : DateTime.now(),
    );
  }

  // 객체를 Firestore 데이터(Map)로 변환
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'birthYear': birthYear,
      'gender': gender,
      'role': role,
      'createdAt': createdAt,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    int? birthYear,
    String? gender,
    String? role,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      birthYear: birthYear ?? this.birthYear,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
