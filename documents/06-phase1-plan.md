# Phase 1 구현 계획서

**기간**: 2-3주  
**목표**: 핵심 기능 작동, 실제 사용 가능한 앱 완성  
**작성일**: 2026-02-02

---

## 📋 Phase 1 체크리스트

### Week 1: Firebase 연동 및 인증 시스템

#### Day 1: Firebase 설정
- [ ] `flutterfire configure` 실행
- [ ] `firebase_options.dart` 생성 확인
- [ ] Firestore 연결 테스트
- [ ] Storage 연결 테스트

#### Day 2-3: 로그인 화면
- [ ] 로그인 UI 디자인 (시니어 친화적)
- [ ] 이메일/비밀번호 로그인 구현
- [ ] 에러 처리 (큰 글씨로 명확한 메시지)
- [ ] 로딩 인디케이터

#### Day 4: 회원가입 화면
- [ ] 회원가입 UI
- [ ] 입력 검증 (이메일, 비밀번호 강도)
- [ ] Firestore에 사용자 정보 저장
- [ ] 환영 메시지

#### Day 5: 소셜 로그인
- [ ] Google 로그인 설정
- [ ] Google 로그인 버튼 추가
- [ ] 신규 사용자 프로필 생성

#### Day 6-7: 프로필 관리
- [ ] 프로필 조회 화면
- [ ] 프로필 수정 화면
- [ ] 프로필 이미지 업로드 (Firebase Storage)
- [ ] 홈 화면에 실제 사용자 이름 표시

---

### Week 2: 소통광장 구현

#### Day 8-9: 게시글 목록
- [ ] Firestore 쿼리 구현
- [ ] 실시간 데이터 스트림 연결
- [ ] 카테고리별 필터링
- [ ] 무한 스크롤 (페이지네이션)

#### Day 10-11: 게시글 작성
- [ ] 작성 화면 UI
- [ ] 제목/내용 입력
- [ ] 카테고리 선택
- [ ] 이미지 선택 (갤러리/카메라)
- [ ] 이미지 업로드 (Firebase Storage)
- [ ] Firestore에 저장

#### Day 12: 게시글 상세 및 수정/삭제
- [ ] 상세 화면 개선
- [ ] 수정 기능 (본인만)
- [ ] 삭제 기능 (본인만)
- [ ] 권한 체크

#### Day 13-14: 댓글 시스템
- [ ] 댓글 목록 표시
- [ ] 댓글 작성
- [ ] 댓글 삭제 (본인만)
- [ ] 댓글 개수 표시

---

### Week 3: 복지알림 및 마무리

#### Day 15-16: 복지알림 실시간 연동
- [ ] Firestore 컬렉션 설계
- [ ] 실시간 데이터 스트림
- [ ] 카테고리별 필터링
- [ ] 이미지 표시

#### Day 17: 관리자 페이지 (간단 버전)
- [ ] 웹 기반 관리 페이지
- [ ] 복지 정보 등록 폼
- [ ] 이미지 업로드
- [ ] 발행/비활성화 기능

#### Day 18: 좋아요 기능
- [ ] 게시글 좋아요 버튼
- [ ] 좋아요 수 표시
- [ ] 사용자별 좋아요 목록 저장
- [ ] 중복 방지

#### Day 19: 검색 기능 (기본)
- [ ] 검색 바 UI
- [ ] 제목/내용 검색
- [ ] 검색 결과 표시

#### Day 20-21: 테스트 및 버그 수정
- [ ] 전체 기능 테스트
- [ ] 버그 수정
- [ ] 성능 최적화
- [ ] 웹 재배포

---

## 🗂 Firestore 데이터 구조

### users 컬렉션
```javascript
users/{userId}
  - name: string
  - email: string
  - phone: string (optional)
  - birthDate: string (optional)
  - profileImage: string (URL)
  - createdAt: timestamp
  - updatedAt: timestamp
```

### posts 컬렉션
```javascript
posts/{postId}
  - authorId: string (reference to users)
  - authorName: string (denormalized)
  - category: string
  - title: string
  - content: string
  - imageUrls: array<string>
  - timestamp: timestamp
  - likes: number
  - likedBy: array<string> (user IDs)
  - commentCount: number
```

### comments 컬렉션
```javascript
comments/{commentId}
  - postId: string (reference to posts)
  - authorId: string (reference to users)
  - authorName: string (denormalized)
  - content: string
  - timestamp: timestamp
```

### welfare 컬렉션
```javascript
welfare/{welfareId}
  - title: string
  - description: string
  - imageUrl: string
  - category: string
  - publishDate: timestamp
  - isActive: boolean
  - createdBy: string (admin user ID)
```

---

## 🔒 Firestore 보안 규칙

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // 헬퍼 함수
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    // 사용자 프로필
    match /users/{userId} {
      allow read: if true;
      allow create: if isSignedIn();
      allow update: if isOwner(userId);
      allow delete: if false; // 삭제 불가
    }
    
    // 게시글
    match /posts/{postId} {
      allow read: if true;
      allow create: if isSignedIn() && 
                      request.resource.data.authorId == request.auth.uid;
      allow update: if isSignedIn() && 
                      resource.data.authorId == request.auth.uid;
      allow delete: if isSignedIn() && 
                      resource.data.authorId == request.auth.uid;
    }
    
    // 댓글
    match /comments/{commentId} {
      allow read: if true;
      allow create: if isSignedIn() && 
                      request.resource.data.authorId == request.auth.uid;
      allow delete: if isSignedIn() && 
                      resource.data.authorId == request.auth.uid;
    }
    
    // 복지 정보
    match /welfare/{welfareId} {
      allow read: if true;
      allow write: if false; // 관리자 페이지에서만 수정
    }
  }
}
```

---

## 📦 필요한 패키지

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Firebase
  firebase_core: ^4.4.0
  cloud_firestore: ^6.1.2
  firebase_auth: ^6.1.4
  firebase_storage: ^13.0.6
  
  # 상태 관리
  provider: ^6.1.1
  
  # UI
  cached_network_image: ^3.3.1
  image_picker: ^1.0.7
  
  # 유틸리티
  intl: ^0.20.2
  url_launcher: ^6.2.2
```

---

## 🎨 UI 컴포넌트 가이드

### 로그인 화면
- **버튼 높이**: 최소 65px
- **글자 크기**: 22px (버튼), 20px (입력 필드)
- **여백**: 20px
- **색상**: primaryColor (#0056B3)

### 게시글 카드
- **제목**: 22px, Bold
- **내용 미리보기**: 18px, 2줄 제한
- **카테고리 뱃지**: 16px, 배경색 primaryColor 10% opacity
- **날짜**: 16px, Grey

### 입력 폼
- **레이블**: 18px
- **입력 필드**: 20px
- **힌트 텍스트**: 18px, Grey
- **에러 메시지**: 18px, Red

---

## ✅ 완료 기준

### 기능 테스트
- [ ] 회원가입 → 로그인 → 프로필 수정 플로우 정상 작동
- [ ] 게시글 작성 → 수정 → 삭제 정상 작동
- [ ] 댓글 작성 → 삭제 정상 작동
- [ ] 좋아요 추가 → 취소 정상 작동
- [ ] 복지 정보 실시간 업데이트 확인
- [ ] 검색 기능 정상 작동

### 성능 테스트
- [ ] 게시글 목록 로딩 시간 < 2초
- [ ] 이미지 업로드 시간 < 5초
- [ ] 앱 초기 로딩 시간 < 3초

### 사용성 테스트
- [ ] 시니어 사용자 테스트 (최소 3명)
- [ ] 글자 크기 적절성 확인
- [ ] 버튼 터치 영역 충분성 확인
- [ ] 에러 메시지 명확성 확인

---

## 🚀 배포 계획

### 웹 배포
```bash
flutter build web --release
firebase deploy --only hosting
```

### 테스트 URL
https://ongojisin-testpj.web.app

---

## 📞 다음 단계

Phase 1 완료 후:
1. 사용자 피드백 수집
2. 버그 수정 및 개선
3. Phase 2 시작 (AI 건강 체크, 일자리, 쇼핑)
