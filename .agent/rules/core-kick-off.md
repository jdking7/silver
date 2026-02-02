---
trigger: always_on
---

# Kick-off Rules (Core)

> **Deep Dive**: [deep-workflow.md](deep-workflow.md)  
> 상세 PRD 템플릿, TDD 프로토콜, 아키텍처 패턴은 위 문서를 참조하세요.

## 🚀 프로젝트 진행 7단계 (Workflow Steps)

| Step | Phase | Action Rule | Detail |
| :--- | :--- | :--- | :--- |
| **0** | **Planning** | `sequential-thinking` 툴 사용 필수. 무작정 코딩 금지. | [Go to Detail](deep-workflow.md#1-planning-phase-sequential-thinking) |
| **1** | **PRD** | 요구사항 명세서 작성 및 사용자 승인 대기. | [Go to Detail](deep-workflow.md#2-prd-template-product-requirements) |
| **2** | **Design** | `project-structure.md` 생성, 폴더 구조 및 아키텍처 확정. | [Go to Detail](deep-workflow.md#3-architecture-design) |
| **3** | **Pre-Code** | 테스트 환경(Jest/Vitest) 설정. | |
| **4** | **Dev (TDD)** | **Red(실패)** -> **Green(구현)** -> **Refactor(개선)** 반복. | [Go to Detail](deep-workflow.md#4-tdd-protocol) |
| **5** | **Verify** | E2E 테스트 및 통합 검증. | |
| **6** | **Refine** | 문서 업데이트(`archive.md`) 및 회고. | [Go to Detail](deep-workflow.md#5-refinement-checklist) |

## 🛑 주요 원칙
1. **Plan First**: 계획 없는 코드는 모두 기술 부채입니다.
2. **Approve First**: PRD와 아키텍처는 사용자 승인 후 진행합니다.
3. **Document First**: 코드를 짜기 전에 문서를 먼저 갱신합니다.
