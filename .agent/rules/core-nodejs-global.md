---
trigger: always_on
---

# Node.js Global Rules (Core)

> **Deep Dive**: [deep-nodejs.md](deep-nodejs.md)  
> `tsconfig.json`, `eslint`, 프로젝트 구조, 에러 핸들링 샘플 코드는 위 문서를 참조하세요.

## 🏗 코딩 표준 (Code Standards)

| Category | Rule | Why? |
| :--- | :--- | :--- |
| **Runtime** | **LTS Version** Only | 안정성 및 장기 지원 보장 |
| **Lang** | **TypeScript** (`strict: true`) | 런타임 에러 방지 |
| **Style** | **Prettier** + **ESLint** | 코드 일관성 유지 |
| **Async** | `async/await` 사용 (Callback ❌) | 가독성 및 에러 핸들링 용이 |
| **Var** | `const` (기본), `let` (필요시) | `var` 사용 절대 금지 |

## 🛡 안전 및 보안 (Safety & Security)

- **Injection 방지**: SQL/NoSQL 쿼리에는 반드시 **ORM**이나 **Parameterized Query** 사용.
- **Input 검증**: API 요청 데이터는 `Zod` 등으로 **스키마 검증** 필수.
- **Error Handling**: `try-catch`로 에러를 잡고, 반드시 **중앙 에러 핸들러**로 위임 (`next(err)`). [Detail](deep-nodejs.md#4-error-handling-patterns)

## ⚠️ 절대 금지 (Never Do)
1. `rm -rf` 등 파괴적 명령 자동 실행.
2. 비밀번호/API Key 하드코딩 (무조건 `.env`).
3. <code>any</code> 타입 남발.
