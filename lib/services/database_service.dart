import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 컬렉션 참조
  CollectionReference get _usersRef => _db.collection('users');

  // 사용자 정보 생성 (회원가입 시)
  Future<void> createUser(UserModel user) async {
    try {
      await _usersRef.doc(user.uid).set(user.toMap());
    } catch (e) {
      print('Error creating user: $e');
      throw '사용자 정보를 저장하는 중 오류가 발생했습니다.';
    }
  }

  // 사용자 정보 조회
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _usersRef.doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      throw '사용자 정보를 불러오는 중 오류가 발생했습니다.';
    }
  }

  // 사용자 정보 수정
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _usersRef.doc(uid).update(data);
    } catch (e) {
      print('Error updating user: $e');
      throw '사용자 정보를 수정하는 중 오류가 발생했습니다.';
    }
  }

  // --- 게시글(Post) 관련 기능 ---

  // 컬렉션 참조
  CollectionReference get _postsRef => _db.collection('posts');

  // 게시글 작성
  Future<void> createPost(PostModel post) async {
    try {
      // id는 Firestore에서 자동 생성된 것을 post 객체에 담아 보내거나,
      // 여기서 add()를 쓰고 id를 나중에 업데이트할 수도 있지만,
      // 보통은 UI에서 이미 id를 비워두고 보냄. 여기서 doc().set() 또는 add() 사용.
      
      // 방법 1: add() 사용 (ID 자동 생성)
      await _postsRef.add(post.toMap());
    } catch (e) {
      print('Error creating post: $e');
      throw '게시글을 저장하는 중 오류가 발생했습니다.';
    }
  }

  // 게시글 목록 조회 (최신순)
  Stream<List<PostModel>> getPosts() {
    return _postsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return PostModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
