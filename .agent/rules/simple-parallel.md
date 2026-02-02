---
trigger: always_on
---

# Google Antigravity Simple Parallel Rule

> **Note**: This is a simplified reference. For full strategy and research backing, see [deep-parallel.md](deep-parallel.md).

## 🔄 Parallel Execution Decision Matrix

Before starting a task, evaluate if it should be parallelized:

| Task Duration | Agent Count | Strategy | Detail Link |
| :--- | :--- | :--- | :--- |
| **< 4 Hours** | 1 (Solo) | Direct Execution | [View Strategy](deep-parallel.md#rule-1-agent-spawning-strategy) |
| **4 - 16 Hours** | 2-3 (Squad) | Frontend + Backend Parallel | [View Strategy](deep-parallel.md#collaboration-patterns) |
| **16+ Hours** | 4+ (Team) | Full Roles (PM/Dev/Ops/QA) | [View Strategy](deep-parallel.md#performance-metrics) |

## 🌿 Git Worktree Cheatsheet

Always use **Worktrees** for parallel agents to avoid conflict.

```bash
# 1. Add Worktree (Isolated Workspace)
git worktree add worktrees/<folder-name> <branch-name>

# 2. List Worktrees
git worktree list

# 3. Remove Worktree (Cleanup)
git worktree remove worktrees/<folder-name>
```

**Rule**: Never allow two agents to edit the same file in the same worktree simultaneously. Assign specialized worktrees (e.g., `worktrees/feature-ui`, `worktrees/feature-api`).

## 🔗 Deep Dives
- **Performance Optimization**: [See Section 8](deep-parallel.md#performance-optimization)
- **Conflict Prevention**: [See Rule 7](deep-parallel.md#rule-7-conflict-prevention)
