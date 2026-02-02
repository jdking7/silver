# Google Antigravity 커스텀 커맨드 규칙 가이드

> **Purpose**: Comprehensive guide for implementing custom slash commands in Google Antigravity as Rules  
> **목적**: Google Antigravity에서 커스텀 슬래시 커맨드를 규칙으로 구현하기 위한 포괄적 가이드

---

## 📋 Table of Contents / 목차

1. [/specify Command](#1-specify-command)
2. [/plan Command](#2-plan-command)
3. [/review Command](#3-review-command)
4. [/compare Command](#4-compare-command)
5. [/debug Command](#5-debug-command)
6. [/refactor Command](#6-refactor-command)
7. [/test Command](#7-test-command)
8. [/document Command](#8-document-command)
9. [Implementation Guide](#implementation-guide)

---

# 1. /specify Command

## 📌 English Version

**Description**: Create detailed specification documents with requirements, constraints, and acceptance criteria

### Rule Definition

```
## /specify Command Rule

When a user triggers the /specify command, follow this exact workflow:

1. **Parse Context** - Identify what needs to be specified (feature, component, API, etc.)

2. **Gather Requirements** - Extract and document:
   - Functional requirements (what it does)
   - Non-functional requirements (performance, security, scalability)
   - Business constraints
   - Technical constraints
   - Acceptance criteria

3. **Structure Documentation**:
   - Title and Overview
   - Problem Statement
   - Requirements Analysis
   - Constraints and Limitations
   - Acceptance Criteria (numbered list)
   - Success Metrics
   - Dependencies and Risks
   - Revision History

4. **Validation** - Review for completeness and clarity

5. **Output Format** - Use markdown with clear sections and bullet points

6. **Ask for Confirmation** - Before finalizing, confirm if specification meets expectations

Important: Always ask for user approval before proceeding to implementation based on specifications.
```

---

## 📌 한글 버전

**설명**: 요구사항, 제약조건, 수용기준을 포함한 상세 명세서 문서 작성

### 규칙 정의

```
## /specify 커맨드 규칙

사용자가 /specify 커맨드를 실행할 때 다음 워크플로우를 따릅니다:

1. **문맥 분석** - 명세가 필요한 항목 식별 (기능, 컴포넌트, API 등)

2. **요구사항 수집** - 다음 항목 추출 및 문서화:
   - 기능 요구사항 (무엇을 하는가)
   - 비기능 요구사항 (성능, 보안, 확장성)
   - 비즈니스 제약조건
   - 기술 제약조건
   - 수용기준

3. **문서 구조화**:
   - 제목 및 개요
   - 문제 정의
   - 요구사항 분석
   - 제약조건 및 한계
   - 수용기준 (번호 목록)
   - 성공 지표
   - 의존성 및 위험 요소
   - 수정 이력

4. **검증** - 완전성과 명확성 검토

5. **출력 형식** - 마크다운 사용, 명확한 섹션 구분

6. **확인 요청** - 최종화 전 사용자에게 명세 타당성 확인

중요: 명세서를 기반으로 구현을 진행하기 전에 항상 사용자 승인을 요청합니다.
```

---

# 2. /plan Command

## 📌 English Version

**Description**: Create structured project plans with phases, milestones, dependencies, and timelines

### Rule Definition

```
## /plan Command Rule

When a user triggers the /plan command, follow this execution workflow:

1. **Understand Scope** - Clarify what project/task needs planning

2. **Define Phases** - Break down the project into logical phases:
   - Phase name
   - Duration estimate
   - Key objectives
   - Deliverables

3. **Set Milestones** - Establish clear checkpoints:
   - Milestone name and date
   - Completion criteria
   - Stakeholder review points

4. **Map Dependencies** - Identify:
   - Task-to-task dependencies
   - Resource dependencies
   - External dependencies
   - Blockers and risks

5. **Create Timeline** - Generate:
   - Gantt-style representation (ASCII or markdown table)
   - Critical path
   - Slack time
   - Buffer periods for unknown unknowns

6. **Define Responsibilities** - Assign:
   - Role assignments
   - Decision makers
   - Review authorities

7. **Risk Assessment** - Document:
   - Identified risks
   - Mitigation strategies
   - Contingency plans

8. **Validation & Approval** - Present plan to user for feedback and adjustment

Format: Use clear hierarchical structure with priorities marked as HIGH/MEDIUM/LOW.
```

---

## 📌 한글 버전

**설명**: 단계, 마일스톤, 의존성, 타임라인을 포함한 구조화된 프로젝트 계획 작성

### 규칙 정의

```
## /plan 커맨드 규칙

사용자가 /plan 커맨드를 실행할 때 다음 실행 워크플로우를 따릅니다:

1. **범위 이해** - 계획이 필요한 프로젝트/작업 명확화

2. **단계 정의** - 프로젝트를 논리적 단계로 분해:
   - 단계명
   - 소요 기간 예상
   - 핵심 목표
   - 산출물

3. **마일스톤 설정** - 명확한 체크포인트 수립:
   - 마일스톤명 및 날짜
   - 완료 기준
   - 이해관계자 검토 시점

4. **의존성 맵핑** - 식별:
   - 업무 간 의존성
   - 리소스 의존성
   - 외부 의존성
   - 차단 요소 및 위험

5. **타임라인 생성** - 다음 항목 생성:
   - 간트 형식 표현 (ASCII 또는 마크다운 테이블)
   - 중요 경로
   - 여유 시간
   - 미지의 사항 대비 버퍼

6. **책임 정의** - 할당:
   - 역할 배정
   - 의사결정자
   - 검토 권한자

7. **위험 평가** - 문서화:
   - 식별된 위험
   - 완화 전략
   - 대안 계획

8. **검증 및 승인** - 사용자에게 계획 제시 및 조정 피드백 수집

형식: 명확한 계층 구조 사용, 우선순위는 HIGH/MEDIUM/LOW로 표시
```

---

# 3. /review Command

## 📌 English Version

**Description**: Perform comprehensive code or document reviews with detailed feedback and improvement suggestions

### Rule Definition

```
## /review Command Rule

When a user triggers the /review command, follow this analysis workflow:

1. **Identify Review Scope** - Determine what to review (code, document, design, etc.)

2. **Establish Review Criteria** - Based on:
   - Code quality standards (naming, structure, comments)
   - Security best practices
   - Performance considerations
   - Maintainability
   - Compliance with project rules
   - Documentation completeness

3. **Perform Analysis**:
   - Line-by-line inspection (for code)
   - Section-by-section review (for documents)
   - Pattern matching against anti-patterns
   - Cross-reference with project standards

4. **Document Findings**:
   - **Critical Issues** (must fix) - marked with 🔴
   - **Major Issues** (should fix) - marked with 🟠
   - **Minor Issues** (nice to fix) - marked with 🟡
   - **Suggestions** (for consideration) - marked with 🟢

5. **Provide Context** - For each issue:
   - What was found
   - Why it's a problem
   - Where it occurs (line/section reference)
   - Example of current vs. improved version

6. **Recommend Solutions** - Offer specific improvements and refactoring suggestions

7. **Approval Criteria** - Clearly state what's needed for approval

8. **Summary Report** - Generate summary with:
   - Overall assessment (PASS/NEEDS REVISION/MAJOR REVISION)
   - Key metrics (if applicable)
   - Next steps

Format: Use color-coded severity markers, code blocks for examples, clear action items.
```

---

## 📌 한글 버전

**설명**: 상세 피드백과 개선 제안을 포함한 포괄적 코드 또는 문서 검토

### 규칙 정의

```
## /review 커맨드 규칙

사용자가 /review 커맨드를 실행할 때 다음 분석 워크플로우를 따릅니다:

1. **검토 범위 식별** - 검토 대상 결정 (코드, 문서, 설계 등)

2. **검토 기준 수립** - 다음 항목에 따라:
   - 코드 품질 표준 (명명, 구조, 주석)
   - 보안 모범 사례
   - 성능 고려사항
   - 유지보수성
   - 프로젝트 규칙 준수 여부
   - 문서 완전성

3. **분석 수행**:
   - 라인 단위 검사 (코드용)
   - 섹션 단위 검토 (문서용)
   - 안티패턴과 패턴 매칭
   - 프로젝트 표준과 교차 검증

4. **발견사항 문서화**:
   - **심각한 문제** (필수 수정) - 🔴 표시
   - **주요 문제** (수정 권장) - 🟠 표시
   - **경미한 문제** (선택 수정) - 🟡 표시
   - **제안** (검토 대상) - 🟢 표시

5. **맥락 제공** - 각 문제에 대해:
   - 발견 내용
   - 문제인 이유
   - 발생 위치 (라인/섹션 참조)
   - 현재 vs 개선된 버전 예시

6. **해결안 권장** - 구체적 개선 및 리팩토링 제안 제시

7. **승인 기준** - 승인에 필요한 항목 명시

8. **요약 보고서** - 다음 내용 포함 요약:
   - 전체 평가 (통과/수정필요/대대적수정)
   - 핵심 지표 (해당하는 경우)
   - 다음 단계

형식: 심각도별 색상 표시, 예시는 코드블록 사용, 명확한 실행 항목
```

---

# 4. /compare Command

## 📌 English Version

**Description**: Perform comparative analysis between multiple options with pros/cons and recommendations

### Rule Definition

```
## /compare Command Rule

When a user triggers the /compare command, follow this comparative analysis workflow:

1. **Identify Comparison Items** - Clarify what's being compared (tools, approaches, designs, etc.)

2. **Define Comparison Criteria** - Establish dimensions:
   - Performance metrics
   - Cost/Budget impact
   - Ease of implementation
   - Maintainability
   - Learning curve
   - Community support
   - Security considerations
   - Scalability potential
   - Integration points
   - Long-term sustainability

3. **Create Comparison Matrix**:
   - Build markdown table with items and criteria
   - Score on consistent scale (1-5, High/Medium/Low, etc.)
   - Highlight key differentiators

4. **Detailed Analysis** - For each item:
   - **Strengths** (3-5 points)
   - **Weaknesses** (3-5 points)
   - **Use cases** (when to choose this)
   - **Trade-offs** (what you gain/lose)

5. **Provide Examples** - Include:
   - Code snippets (if applicable)
   - Real-world usage scenarios
   - Common pitfalls

6. **Generate Recommendations**:
   - Primary recommendation with reasoning
   - Alternative recommendations for specific scenarios
   - Decision framework

7. **Highlight Risks** - Document:
   - Migration risks (if applicable)
   - Vendor lock-in considerations
   - Deprecation/EOL concerns

8. **Final Verdict** - Clear summary with:
   - Recommended option
   - Confidence level
   - Next decision point (if applicable)

Format: Use comparative tables, clear headers, evidence-based recommendations, consider project context.
```

---

## 📌 한글 버전

**설명**: 장단점과 권장사항이 포함된 여러 옵션 간 비교 분석

### 규칙 정의

```
## /compare 커맨드 규칙

사용자가 /compare 커맨드를 실행할 때 다음 비교 분석 워크플로우를 따릅니다:

1. **비교 항목 식별** - 비교 대상 명확화 (도구, 접근 방식, 설계 등)

2. **비교 기준 정의** - 다음 차원 수립:
   - 성능 지표
   - 비용/예산 영향
   - 구현 난이도
   - 유지보수성
   - 학습 곡선
   - 커뮤니티 지원
   - 보안 고려사항
   - 확장성 잠재력
   - 통합 지점
   - 장기적 지속성

3. **비교 매트릭스 생성**:
   - 마크다운 테이블로 항목과 기준 작성
   - 일관된 스케일로 점수 매김 (1-5, 높음/중간/낮음 등)
   - 핵심 차별화 요소 강조

4. **상세 분석** - 각 항목에 대해:
   - **장점** (3-5개)
   - **단점** (3-5개)
   - **사용 사례** (언제 이것을 선택할지)
   - **트레이드오프** (얻는 것/잃는 것)

5. **예시 제공** - 다음 포함:
   - 코드 스니펫 (해당하는 경우)
   - 실제 사용 시나리오
   - 일반적 함정

6. **권장사항 생성**:
   - 근거가 포함된 주요 권장사항
   - 특정 시나리오용 대안 권장
   - 의사결정 프레임워크

7. **위험 강조** - 다음 문서화:
   - 마이그레이션 위험 (해당하는 경우)
   - 벤더 종속성 고려사항
   - 단종/지원 종료 문제

8. **최종 판정** - 명확한 요약:
   - 권장 옵션
   - 신뢰도 수준
   - 다음 의사결정 시점 (해당하는 경우)

형식: 비교 테이블 사용, 명확한 제목, 근거 기반 권장, 프로젝트 맥락 고려
```

---

# 5. /debug Command

## 📌 English Version

**Description**: Systematic debugging and issue diagnosis with root cause analysis

### Rule Definition

```
## /debug Command Rule

When a user triggers the /debug command, follow this systematic debugging workflow:

1. **Gather Information** - Collect:
   - Error message/symptoms
   - Environment details (OS, runtime version, dependencies)
   - Steps to reproduce
   - Expected vs. actual behavior
   - Recent changes
   - Logs and stack traces

2. **Initial Analysis** - Perform:
   - Pattern recognition against known issues
   - Error categorization (syntax, logic, runtime, etc.)
   - Scope isolation (single file, module, system)

3. **Create Hypothesis** - Develop:
   - Most likely causes (ranked by probability)
   - Potential contributing factors
   - Assumptions to validate

4. **Design Test Cases**:
   - Tests to confirm/reject hypotheses
   - Minimal reproducible example
   - Regression tests

5. **Provide Debugging Steps**:
   - Numbered steps with specific commands/actions
   - Expected outputs at each step
   - How to interpret results

6. **Root Cause Analysis** - Once identified:
   - Why it happened
   - When it was introduced
   - System components affected

7. **Provide Solutions**:
   - Immediate workaround (if needed)
   - Permanent fix
   - Prevention strategies

8. **Document Findings** - Create:
   - Issue summary
   - Root cause explanation
   - Solution code/changes
   - Test verification

Format: Use code blocks for commands, numbered procedures, clear cause-and-effect relationships.
```

---

## 📌 한글 버전

**설명**: 근본 원인 분석이 포함된 체계적 디버깅 및 문제 진단

### 규칙 정의

```
## /debug 커맨드 규칙

사용자가 /debug 커맨드를 실행할 때 다음 체계적 디버깅 워크플로우를 따릅니다:

1. **정보 수집** - 다음 내용 수집:
   - 오류 메시지/증상
   - 환경 상세정보 (OS, 런타임 버전, 의존성)
   - 재현 단계
   - 예상 vs 실제 동작
   - 최근 변경사항
   - 로그 및 스택 트레이스

2. **초기 분석** - 수행:
   - 알려진 문제와 패턴 인식
   - 오류 분류 (문법, 로직, 런타임 등)
   - 범위 격리 (단일 파일, 모듈, 시스템)

3. **가설 수립** - 개발:
   - 가장 가능성 높은 원인 (확률순 순위)
   - 잠재적 기여 요소
   - 검증할 가정

4. **테스트 케이스 설계**:
   - 가설 확인/거부 테스트
   - 최소 재현 가능 예시
   - 회귀 테스트

5. **디버깅 단계 제공**:
   - 특정 커맨드/액션이 포함된 번호 매김 단계
   - 각 단계의 예상 출력
   - 결과 해석 방법

6. **근본 원인 분석** - 확인 후:
   - 발생 이유
   - 도입된 시점
   - 영향받는 시스템 컴포넌트

7. **해결안 제공**:
   - 즉시 임시 방편 (필요한 경우)
   - 영구적 해결
   - 예방 전략

8. **발견사항 문서화** - 작성:
   - 문제 요약
   - 근본 원인 설명
   - 해결 코드/변경
   - 테스트 검증

형식: 커맨드는 코드블록 사용, 번호 매김 절차, 명확한 인과관계
```

---

# 6. /refactor Command

## 📌 English Version

**Description**: Code refactoring with improvement suggestions, safety guarantees, and test coverage

### Rule Definition

```
## /refactor Command Rule

When a user triggers the /refactor command, follow this safe refactoring workflow:

1. **Understand Context** - Gather:
   - Code to refactor
   - Current functionality
   - Performance bottlenecks
   - Maintainability issues
   - Test coverage
   - Constraints

2. **Define Refactoring Goals** - Establish:
   - Primary objective (readability, performance, maintainability)
   - Scope boundaries
   - Success criteria
   - Risk tolerance

3. **Pre-Refactoring Analysis**:
   - Identify existing tests
   - Note critical paths
   - Document current behavior
   - Plan gradual migration if needed

4. **Propose Changes**:
   - High-level refactoring strategy
   - Detailed before/after code
   - Explanation of improvements
   - Potential risks

5. **Provide Implementation Strategy**:
   - Step-by-step refactoring steps
   - Safe intermediate checkpoints
   - How to verify at each step
   - Rollback procedures

6. **Ensure Test Coverage**:
   - Identify required tests
   - Suggest new test cases
   - Verify no test breakage
   - Add edge case coverage

7. **Performance Verification**:
   - Estimate performance impact
   - Suggest benchmarking approach
   - Memory/CPU implications

8. **Final Validation**:
   - Checklist before commit
   - Suggested code review points
   - Documentation updates needed

Format: Provide complete before/after code examples, safety-first approach, testing at each stage.
```

---

## 📌 한글 버전

**설명**: 개선 제안, 안전 보장, 테스트 커버리지가 포함된 코드 리팩토링

### 규칙 정의

```
## /refactor 커맨드 규칙

사용자가 /refactor 커맨드를 실행할 때 다음 안전한 리팩토링 워크플로우를 따릅니다:

1. **맥락 이해** - 수집:
   - 리팩토링할 코드
   - 현재 기능
   - 성능 병목
   - 유지보수성 문제
   - 테스트 커버리지
   - 제약조건

2. **리팩토링 목표 정의** - 수립:
   - 주요 목표 (가독성, 성능, 유지보수성)
   - 범위 경계
   - 성공 기준
   - 위험 허용도

3. **리팩토링 전 분석**:
   - 기존 테스트 식별
   - 중요 경로 기록
   - 현재 동작 문서화
   - 필요시 점진적 마이그레이션 계획

4. **변경안 제시**:
   - 고수준 리팩토링 전략
   - 상세 변경 전/후 코드
   - 개선사항 설명
   - 잠재적 위험

5. **구현 전략 제공**:
   - 단계별 리팩토링 단계
   - 안전한 중간 체크포인트
   - 각 단계 검증 방법
   - 롤백 절차

6. **테스트 커버리지 확보**:
   - 필수 테스트 식별
   - 새 테스트 케이스 제안
   - 테스트 손상 확인 없음
   - 엣지 케이스 커버리지 추가

7. **성능 검증**:
   - 성능 영향 예상
   - 벤치마킹 접근 제안
   - 메모리/CPU 함의

8. **최종 검증**:
   - 커밋 전 체크리스트
   - 제안된 코드 리뷰 포인트
   - 필요한 문서 업데이트

형식: 완전한 변경 전/후 코드 예시 제공, 안전 우선 접근, 각 단계 테스트
```

---

# 7. /test Command

## 📌 English Version

**Description**: Generate comprehensive test cases and test strategies with coverage analysis

### Rule Definition

```
## /test Command Rule

When a user triggers the /test command, follow this comprehensive test generation workflow:

1. **Understand Scope** - Analyze:
   - Function/module to test
   - Input parameters and types
   - Output expectations
   - Edge cases
   - Error conditions
   - Dependencies

2. **Define Test Strategy**:
   - Test pyramid levels (unit, integration, e2e)
   - Coverage targets (line, branch, path)
   - Testing frameworks and tools
   - Mock/stub strategy

3. **Identify Test Cases** - Generate:
   - **Happy Path** (normal operation)
   - **Edge Cases** (boundary conditions)
   - **Error Cases** (exception handling)
   - **Performance Cases** (stress, load)
   - **Security Cases** (input validation, injection)

4. **Create Test Scaffolding**:
   - Test file structure
   - Setup/teardown procedures
   - Mock data generators
   - Helper functions

5. **Write Test Cases**:
   - Arrange-Act-Assert pattern
   - Clear descriptive test names
   - Single responsibility per test
   - Assertion explanations

6. **Add Documentation**:
   - What each test validates
   - Why test exists
   - Known limitations

7. **Coverage Analysis**:
   - Line coverage targets
   - Branch coverage analysis
   - Identify untested paths
   - Suggest additional tests for gaps

8. **Quality Metrics**:
   - Test count recommendations
   - Estimated execution time
   - Maintenance burden
   - ROI of additional tests

Format: Complete working test code, clear test descriptions, coverage visualizations.
```

---

## 📌 한글 버전

**설명**: 커버리지 분석이 포함된 포괄적 테스트 케이스 및 테스트 전략 생성

### 규칙 정의

```
## /test 커맨드 규칙

사용자가 /test 커맨드를 실행할 때 다음 포괄적 테스트 생성 워크플로우를 따릅니다:

1. **범위 이해** - 분석:
   - 테스트할 함수/모듈
   - 입력 매개변수 및 타입
   - 출력 기대값
   - 엣지 케이스
   - 오류 조건
   - 의존성

2. **테스트 전략 정의**:
   - 테스트 피라미드 수준 (단위, 통합, E2E)
   - 커버리지 목표 (라인, 분기, 경로)
   - 테스트 프레임워크 및 도구
   - Mock/Stub 전략

3. **테스트 케이스 식별** - 생성:
   - **정상 경로** (정상 작동)
   - **엣지 케이스** (경계 조건)
   - **오류 케이스** (예외 처리)
   - **성능 케이스** (스트레스, 로드)
   - **보안 케이스** (입력 검증, 주입)

4. **테스트 스캐폴딩 생성**:
   - 테스트 파일 구조
   - 설정/정리 절차
   - Mock 데이터 생성기
   - 헬퍼 함수

5. **테스트 케이스 작성**:
   - Arrange-Act-Assert 패턴
   - 명확한 설명적 테스트명
   - 테스트당 단일 책임
   - 어설션 설명

6. **문서화 추가**:
   - 각 테스트가 검증하는 내용
   - 테스트 존재 이유
   - 알려진 한계

7. **커버리지 분석**:
   - 라인 커버리지 목표
   - 분기 커버리지 분석
   - 테스트되지 않은 경로 식별
   - 간격 채우기 위한 추가 테스트 제안

8. **품질 지표**:
   - 권장 테스트 수
   - 예상 실행 시간
   - 유지보수 부담
   - 추가 테스트의 ROI

형식: 완전히 작동하는 테스트 코드, 명확한 테스트 설명, 커버리지 시각화
```

---

# 8. /document Command

## 📌 English Version

**Description**: Generate comprehensive documentation with examples, diagrams, and API references

### Rule Definition

```
## /document Command Rule

When a user triggers the /document command, follow this comprehensive documentation workflow:

1. **Analyze Content** - Understand:
   - Code/feature to document
   - Target audience
   - Documentation scope
   - Existing documentation gaps

2. **Create Documentation Structure**:
   - Overview and Quick Start
   - Installation/Setup (if applicable)
   - Core Concepts
   - API Reference
   - Examples and Tutorials
   - Troubleshooting
   - FAQ
   - Contributing Guide (if needed)

3. **Write Core Sections**:
   - Clear, concise descriptions
   - Avoid jargon (or explain it)
   - Progressive complexity
   - Consistent terminology

4. **Add Examples**:
   - Working code snippets
   - Real-world use cases
   - Common patterns
   - Anti-patterns to avoid

5. **Include Visuals** - Suggest:
   - Architecture diagrams
   - Flow diagrams
   - UML diagrams (if applicable)
   - Screenshots

6. **Create API Reference**:
   - Function/method signatures
   - Parameter descriptions
   - Return value documentation
   - Error/exception documentation
   - Usage examples for each

7. **Add Quality Elements**:
   - Table of contents
   - Cross-references
   - Search keywords/SEO
   - Versioning notes

8. **Validation**:
   - Check code examples run
   - Verify links work
   - Ensure completeness
   - Peer review suggestions

Format: Markdown with clear hierarchy, working examples, beginner-friendly explanations.
```

---

## 📌 한글 버전

**설명**: 예시, 다이어그램, API 참조를 포함한 포괄적 문서 생성

### 규칙 정의

```
## /document 커맨드 규칙

사용자가 /document 커맨드를 실행할 때 다음 포괄적 문서 작성 워크플로우를 따릅니다:

1. **콘텐츠 분석** - 이해:
   - 문서화할 코드/기능
   - 대상 고객
   - 문서 범위
   - 기존 문서 간격

2. **문서 구조 생성**:
   - 개요 및 빠른 시작
   - 설치/설정 (해당하는 경우)
   - 핵심 개념
   - API 참조
   - 예시 및 튜토리얼
   - 트러블슈팅
   - FAQ
   - 기여 가이드 (필요시)

3. **핵심 섹션 작성**:
   - 명확하고 간결한 설명
   - 전문 용어 회피 (또는 설명)
   - 점진적 복잡성
   - 일관된 용어

4. **예시 추가**:
   - 작동하는 코드 스니펫
   - 실제 사용 사례
   - 일반적 패턴
   - 피해야 할 안티패턴

5. **시각 자료 포함** - 제안:
   - 아키텍처 다이어그램
   - 플로우 다이어그램
   - UML 다이어그램 (해당하는 경우)
   - 스크린샷

6. **API 참조 생성**:
   - 함수/메서드 서명
   - 매개변수 설명
   - 반환값 문서화
   - 오류/예외 문서화
   - 각각에 대한 사용 예시

7. **품질 요소 추가**:
   - 목차
   - 상호참조
   - 검색 키워드/SEO
   - 버전 정보

8. **검증**:
   - 코드 예시 실행 확인
   - 링크 작동 확인
   - 완전성 확인
   - 피어 리뷰 제안

형식: 명확한 계층 구조의 마크다운, 작동하는 예시, 초보자 친화적 설명
```

---

# Implementation Guide

## How to Use These Rules in Antigravity

### Step 1: Access Rules Configuration

1. Open Google Antigravity
2. Click the **Agent Manager** (chat panel)
3. Click the **three dots** (…) in the upper right corner
4. Select **"Customizations"**
5. Click on **"Rules"** tab

### Step 2: Create Global Rules (Optional)

For rules that apply to **all projects**:

1. Click **"+ Global"** button
2. This creates `~/.gemini/GEMINI.md`
3. Add the command rules below

### Step 3: Create Project/Workspace Rules

For rules specific to **this project**:

1. Click **"+ Workspace"** or **"+ Project"** button
2. This creates `.gemini/GEMINI.md` in your project root
3. Add the command rules below

### Step 4: Add Rules Content

Copy the rule definitions from sections 1-8 above and paste into the GEMINI.md file.

**Example format:**

```markdown
# Custom Command Rules

## /specify Command Rule

When a user triggers the /specify command, follow this exact workflow:
[... rule content ...]

## /plan Command Rule

When a user triggers the /plan command, follow this execution workflow:
[... rule content ...]

# [Add other commands as needed]
```

### Step 5: Verify Rules Are Applied

1. Save the GEMINI.md file
2. In the Agent Manager chat, type: "Check if all custom command rules are applied"
3. The agent should confirm that the rules are recognized

---

## Usage Examples

### Example 1: Using /specify

```
User: /specify Create a user authentication API

Agent Response (following the /specify rule):
✅ Specification Document

Title: User Authentication API Specification
Overview: [...]
Functional Requirements: [...]
Acceptance Criteria: [...]
[Provides complete specification]

Do you approve this specification for implementation?
```

### Example 2: Using /plan

```
User: /plan the development of this authentication system

Agent Response (following the /plan rule):
✅ Project Plan

Phase 1: Design & Planning (2 weeks)
  - Objectives: [...]
  - Deliverables: [...]

Phase 2: Core Implementation (3 weeks)
  - Objectives: [...]
  - Deliverables: [...]

[Includes timeline, milestones, risks, dependencies]
```

### Example 3: Using /review

```
User: /review this authentication controller code

Agent Response (following the /review rule):
✅ Code Review Report

Overall Assessment: NEEDS REVISION

🔴 Critical Issues: 2
🟠 Major Issues: 3
🟡 Minor Issues: 5
🟢 Suggestions: 8

[Detailed findings with code examples and solutions]
```

---

## Best Practices

1. **Keep Rules Updated** - Review and update rules quarterly
2. **Test Commands** - Use each command in a test project first
3. **Document Variations** - Add project-specific variations in Project Rules
4. **Version Control** - Check `.gemini/GEMINI.md` into git
5. **Team Alignment** - Share Global Rules with team members
6. **Feedback Loop** - Collect feedback from team and refine rules
7. **Layered Rules** - Use both Global and Project rules for maximum flexibility

---

## Troubleshooting

**Q: Commands are not recognized**
- A: Make sure the rule text contains the command name (e.g., "/specify")
- A: Save the GEMINI.md file and refresh Antigravity

**Q: Rules are not being applied**
- A: Check that the rule file is in the correct location
- A: Verify the agent can read the .gemini directory
- A: Ask the agent directly: "Are my custom rules loaded?"

**Q: Want to add more commands**
- A: Follow the same pattern as the 8 commands provided
- A: Create clear, step-by-step workflows
- A: Test with real use cases

---

## File Structure Reference

```
project-root/
├── .gemini/
│   ├── GEMINI.md          # Project Rules (custom commands)
│   └── commands/          # Project-scoped slash commands (optional)
│       ├── review.toml
│       └── debug.toml
├── src/
├── tests/
└── README.md
```

**Global Rules Location:**
```
~/.gemini/
├── GEMINI.md              # Global Rules (applies to all projects)
└── commands/              # Global slash commands (optional)
```

---

## References

- [Google Antigravity Documentation](https://antigravity.google/docs/home)
- [Antigravity Rules Guide](https://antigravity.codes/tutorial)
- [Gemini CLI Custom Slash Commands](https://cloud.google.com/blog/topics/developers-practitioners/gemini-cli-custom-slash-commands)
- [Agent-First Development Best Practices](https://skywork.ai/blog/agent/antigravity-terminal-automation/)

---

**Document Version**: 1.0  
**Last Updated**: December 12, 2025  
**Language**: Bilingual (English / 한국어)