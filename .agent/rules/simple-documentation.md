---
trigger: always_on
---

# Document Rules (Simple)

> **Deep Dive**: [deep-documentation.md](deep-documentation.md)  
> 상세 템플릿과 메타데이터 표준은 위 문서를 참조하세요.

## 📂 저장소 표준 (Repository Standards)

| Type | Path | Purpose |
| :--- | :--- | :--- |
| **Index** | `documents/00-project-doc-archive.md` | **[필수]** 모든 문서의 목차 및 상태 관리 |
| **Task** | `documents/artifacts/tasklist/` | 할 일, 체크리스트 |
| **Tech** | `documents/artifacts/implementation/` | 설계도, 구조도(`project-structure.md`) |
| **Guide** | `documents/artifacts/walk-through/` | 사용자 매뉴얼 |

## ⚡ 문서화 워크플로우 (Quick Workflow)

1. **Check**: 작업 전 `00-project-doc-archive.md`를 열어 현재 인덱스를 확인합니다.
2. **Write**: 문서를 작성할 때 반드시 **Markdown Frontmatter**를 포함합니다.
   ```markdown
   ---
   Title: {문서 제목}
   Date: YYYY-MM-DD
   Updates: 00-project-doc-archive.md
   ---
   ```
3. **Link**: 작성 완료 후 `00-project-doc-archive.md`에 링크를 추가합니다.

## 📌 주요 규칙
- **변경 이력**: 문서 하단에 `[Document History]` 섹션 필수.
- **다이어그램**: 복잡한 로직은 텍스트 대신 **Mermaid** 사용 권장.