---
trigger: always_on
---

# Antigravity Workflows (Simple)

> **Deep Dive**: [deep-workflow.md](deep-workflow.md) (Full 100 List)  
> **Usage Guide**: [core-usage-guide.md](core-usage-guide.md) (Scenarios & Tips)

## 📋 요약 (Summary)

Google Antigravity 워크플로우는 **100개의 목적 기반 프로세스**입니다.
상황에 맞는 워크플로우를 선택하여 **품질**, **속도**, **안정성**을 확보하세요.

## 🚀 카테고리 맵 (Category Map)

| Category | Description | Key Workflows |
| :--- | :--- | :--- |
| **Project** | 기획 및 설계 | `WF-P01`(Kickoff), `WF-P02`(Stack) |
| **Code Quality** | 품질 보증 | `WF-CQ01`(Review), `WF-CQ03`(Test) |
| **Development** | 기능 개발 | `WF-D01`(Feature), `WF-D02`(Bugfix) |
| **Frontend** | UI/UX 구현 | `WF-FE01`(Component), `WF-FE06`(Perf) |
| **Backend** | API/로직 | `WF-D03`(API), `WF-D13`(Testing) |
| **DevOps** | 배포/인프라 | `WF-D14`(Release), `WF-DO01`(Deploy) |

## ⚡ 추천 조합 (Essential Combos)

1. **Start Project**: `WF-P01` → `WF-D01` → `WF-CQ01`
2. **Fix Bug**: `WF-D02` → `WF-CQ08` (Security)
3. **Optimize**: `WF-CQ06` (Profile) → `WF-FE06` (Frontend)

## ⚠️ 핵심 원칙

- **Select First**: 작업을 시작하기 전에 "어떤 워크플로우를 쓸지" 먼저 결정하세요.
- **Checklist**: 각 워크플로우의 체크리스트는 **완료 기준(DoD)**입니다.
- **Parallel**: 팀원(또는 여러 에이전트)과 함께 다른 워크플로우를 **병렬**로 실행하세요.
