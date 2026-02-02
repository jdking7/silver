import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 현재 사용자
  User? get currentUser => _auth.currentUser;

  // 인증 상태 스트림
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 이메일/비밀번호 회원가입
  Future<User?> signUpWithEmail(String email, String password, String name) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Auth 프로필에 이름 업데이트
      if (result.user != null) {
        await result.user!.updateDisplayName(name);
        await result.user!.reload(); // 프로필 갱신
        return _auth.currentUser; // 갱신된 정보 반환
      }
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuth Error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('❌ Unknown Error: $e');
      throw '회원가입 중 오류가 발생했습니다.';
    }
  }

  // 이메일/비밀번호 로그인
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuth Error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('❌ Unknown Error: $e');
      throw '로그인 중 오류가 발생했습니다.';
    }
  }

  // Google 로그인 (임시 비활성화 - Web 호환성 문제)
  Future<User?> signInWithGoogle() async {
    throw '현재 Google 로그인은 준비 중입니다.\n이메일로 로그인해주세요.';
  }

  // 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
    await setAutoLogin(false);
  }

  // 자동 로그인 설정 저장
  Future<void> setAutoLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auto_login', value);
  }

  // 자동 로그인 설정 불러오기
  Future<bool> getAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('auto_login') ?? false;
  }

  // Firebase Auth 에러 처리
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return '등록되지 않은 이메일입니다.';
      case 'wrong-password':
        return '비밀번호가 올바르지 않습니다.';
      case 'invalid-email':
        return '이메일 형식이 올바르지 않습니다.';
      case 'user-disabled':
        return '비활성화된 계정입니다.';
      case 'too-many-requests':
        return '너무 많은 시도가 있었습니다.\n잠시 후 다시 시도해주세요.';
      case 'network-request-failed':
        return '네트워크 연결을 확인해주세요.';
      case 'invalid-credential':
        return '이메일 또는 비밀번호가 올바르지 않습니다.';
      case 'email-already-in-use':
        return '이미 사용 중인 이메일입니다.';
      case 'weak-password':
        return '비밀번호는 6자 이상이어야 합니다.';
      default:
        return '로그인에 실패했습니다.\n다시 시도해주세요.';
    }
  }
}
