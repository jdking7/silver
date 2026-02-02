# 온고지신 개발 로드맵

**작성일**: 2026-02-02  
**현재 완성도**: 약 40%  
**예상 개발 기간**: 6-8주

---

## 🎯 개발 Phase 요약

| Phase | 기간 | 주요 내용 | 목표 |
|-------|------|-----------|------|
| **Phase 1** | 2-3주 | Firebase 연동, 인증, 소통광장, 복지알림 | 핵심 기능 작동 |
| **Phase 2** | 2-3주 | AI 건강, 일자리, 쇼핑, 알림, 검색 | 모든 메뉴 구현 |
| **Phase 3** | 1-2주 | UI/UX 개선, 오프라인, 보안 | 사용성 향상 |
| **Phase 4** | 1주 | Android/iOS 앱 스토어 배포 | 정식 출시 |

---

## 🔴 Phase 1: 기본 기능 (2-3주)

### 1.1 Firebase 완전 연동 (1일)
**현재 상태**: SDK만 설치, 실제 연동 안 됨

**작업 내용**:
```bash
flutterfire configure --project=ongojisin-testpj
```

- [ ] `firebase_options.dart` 생성
- [ ] Firestore 실시간 데이터 연동
- [ ] Firebase Storage 이미지 업로드 설정
- [ ] 오프라인 캐싱 활성화

---

### 1.2 인증 시스템 (3-4일)
**현재 상태**: 미구현

**구현 화면**:
- [ ] 로그인 화면
  - 이메일/비밀번호
  - Google 소셜 로그인
  - 전화번호 인증
- [ ] 회원가입 화면
- [ ] 비밀번호 찾기
- [ ] 자동 로그인

**Firestore 구조**:
```
users/{userId}
  - name: "김철수"
  - birthDate: "1950-01-01"
  - phone: "010-1234-5678"
  - profileImage: "https://..."
  - createdAt: Timestamp
```

---

### 1.3 사용자 프로필 관리 (2일)
**현재 상태**: 하드코딩 ("김어르신")

**구현 내용**:
- [ ] 프로필 조회
- [ ] 프로필 수정 화면
- [ ] 프로필 이미지 업로드
- [ ] 홈 화면에 실제 사용자 이름 표시

---

### 1.4 소통광장 완전 구현 (5-6일)
**현재 상태**: 더미 데이터만 표시

**구현 기능**:
- [ ] 게시글 작성
  - 제목, 내용 입력
  - 카테고리 선택
  - 이미지 업로드 (최대 3장)
- [ ] 게시글 수정/삭제 (본인만)
- [ ] 댓글 시스템
- [ ] 좋아요 기능
- [ ] 검색 기능

**Firestore 구조**:
```
posts/{postId}
  - authorId: "user123"
  - category: "건강"
  - title: "겨울철 무릎 관절 관리법"
  - content: "..."
  - imageUrls: ["url1", "url2"]
  - timestamp: Timestamp
  - likes: 15
  - commentCount: 3

comments/{commentId}
  - postId: "post123"
  - authorId: "user456"
  - content: "좋은 정보 감사합니다!"
  - timestamp: Timestamp
```

---

### 1.5 복지알림 실시간 업데이트 (4-5일)
**현재 상태**: 정적 데이터 3개

**구현 내용**:
- [ ] Firestore 연동
- [ ] 관리자 페이지 (별도 웹 앱)
- [ ] 이미지 첨부 기능
- [ ] 카테고리별 필터링

**Firestore 구조**:
```
welfare/{welfareId}
  - title: "2024년 고령자 고용지원금"
  - description: "..."
  - imageUrl: "https://..."
  - publishDate: Timestamp
  - category: "고용지원"
  - isActive: true
```

---

## 🟡 Phase 2: 핵심 기능 확장 (2-3주)

### 2.1 AI 건강 체크 (3-4일)
**현재 상태**: 화면만 존재

**구현 방법**: Gemini API 연동 (권장)

```dart
import 'package:google_generative_ai/google_generative_ai.dart';

final model = GenerativeModel(
  model: 'gemini-pro',
  apiKey: 'YOUR_API_KEY',
);
```

**구현 내용**:
- [ ] 채팅 UI (말풍선)
- [ ] 음성 입력 기능
- [ ] 대화 기록 저장
- [ ] 면책 조항 표시

---

### 2.2 일자리 정보 (5-6일)
**현재 상태**: 빈 화면

**구현 방법**:
- [ ] 워크넷 API 연동 (고용노동부)
- [ ] 자체 일자리 등록 시스템

**Firestore 구조**:
```
jobs/{jobId}
  - title: "경비원 모집"
  - company: "○○아파트"
  - location: "서울 강남구"
  - salary: "월 200만원"
  - ageRange: "60-70세"
  - description: "..."
  - deadline: Timestamp
```

**기능**:
- [ ] 지역별 필터링
- [ ] 급여별 필터링
- [ ] 지원하기 기능

---

### 2.3 쇼핑 기능 (2-3일)
**현재 상태**: 빈 화면

**구현 방법**: 제휴 쇼핑몰 링크 (권장)

**구현 내용**:
- [ ] 시니어 친화 상품 큐레이션
- [ ] 카테고리별 정리
  - 건강식품
  - 생활용품
  - 의료기기
- [ ] 외부 쇼핑몰 링크 연결

---

### 2.4 알림 시스템 (3-4일)
**현재 상태**: 알림 아이콘만 존재

**구현 내용**:
```yaml
dependencies:
  firebase_messaging: ^15.0.0
```

- [ ] FCM 설정
- [ ] 알림 타입
  - 새 복지 정보
  - 댓글 알림
  - 좋아요 알림
  - 일자리 마감 임박
- [ ] 알림 목록 화면
- [ ] 알림 설정 화면

---

### 2.5 검색 기능 (3일)
**현재 상태**: 없음

**구현 내용**:
- [ ] 통합 검색 (게시글, 복지, 일자리)
- [ ] 검색 기록
- [ ] 인기 검색어
- [ ] 필터링 (날짜, 카테고리)

---

## 🟢 Phase 3: 개선 및 최적화 (1-2주)

### 3.1 UI/UX 개선 (3-4일)

**접근성 향상**:
- [ ] 음성 안내 (TTS)
  ```yaml
  dependencies:
    flutter_tts: ^4.0.0
  ```
- [ ] 글자 크기 조절 (3단계)
- [ ] 고대비 모드
- [ ] 다크 모드
- [ ] 간편 모드

---

### 3.2 오프라인 지원 (2일)
**현재 상태**: 인터넷 필수

**구현 내용**:
```dart
FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: true,
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
);
```

- [ ] Firestore 오프라인 캐싱
- [ ] 읽은 게시글 로컬 저장
- [ ] 작성 중인 글 임시 저장
- [ ] 네트워크 상태 감지

---

### 3.3 보안 강화 (2-3일)

**Firestore 보안 규칙**:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
    
    match /posts/{postId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.authorId;
    }
  }
}
```

**개인정보 보호**:
- [ ] 개인정보 처리방침
- [ ] 이용약관
- [ ] 동의 화면
- [ ] 데이터 암호화

---

### 3.4 분석 도구 (1-2일)

**Firebase Analytics**:
```dart
await FirebaseAnalytics.instance.logEvent(
  name: 'post_created',
  parameters: {'category': '건강'},
);
```

- [ ] 사용자 행동 분석
- [ ] Crashlytics 설정
- [ ] Performance Monitoring

---

## 🔵 Phase 4: 앱 스토어 배포 (1주)

### 4.1 Android 배포 (2-3일)

**준비 사항**:
- [ ] Android Studio 설치
- [ ] 앱 아이콘 및 스플래시 스크린
- [ ] 앱 서명 키 생성
- [ ] Google Play Console 등록
- [ ] AAB 빌드 및 업로드

---

### 4.2 iOS 배포 (3-4일)

**준비 사항**:
- [ ] macOS 개발 환경
- [ ] Xcode 설치
- [ ] Apple Developer 계정 ($99/년)
- [ ] 프로비저닝 프로파일
- [ ] App Store Connect 등록
- [ ] IPA 빌드 및 업로드

---

## 📊 추가 기능 (선택사항)

### 소셜 기능 (7-10일)
- 친구 시스템
- 1:1 채팅
- 그룹 채팅
- 모임 기능

### 건강 관리 (5-7일)
- 복약 알림
- 건강 기록 (혈압, 혈당)
- 병원 예약 연동

### 교육 콘텐츠 (4-5일)
- 디지털 교육
- 금융 사기 예방
- 건강 정보

---

## 💰 예상 비용

### 개발 인력
- **총 개발 기간**: 6-8주 (1인 기준)

### 외부 서비스
- Firebase: 무료 플랜 시작 (사용량에 따라 유료 전환)
- Apple Developer: $99/년
- Google Play: $25 (1회)
- 도메인 (선택): $10-20/년

---

## 🚀 시작하기

### 즉시 실행 가능한 명령어
```bash
# Firebase 설정
flutterfire configure --project=ongojisin-testpj

# 필요한 패키지 추가
flutter pub add firebase_messaging
flutter pub add google_generative_ai
flutter pub add flutter_tts
flutter pub add shared_preferences

# 개발 시작!
```

---

## 📞 다음 단계

1. Phase 1 상세 계획 검토
2. Firebase 설정 완료
3. 인증 시스템 개발 시작

**문의사항이나 우선순위 조정이 필요하시면 말씀해주세요!**
