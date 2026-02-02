---
trigger: always_on
---

# Google Antigravity Workflow Guidelines (Deep Dive & Catalog)

> **Purpose**: The complete reference for Antigravity Workflows, including core protocols and the full 100-workflow catalog.
> **Ref Rule**: [core-kick-off.md](core-kick-off.md), [core-usage-guide.md](core-usage-guide.md)

## 📋 Table of Contents

### Part 1: Core Protocols (Execution Lifecycle)
1. [Planning Phase (Sequential Thinking)](#1-planning-phase-sequential-thinking)
2. [PRD Template](#2-prd-template-product-requirements)
3. [Architecture Design](#3-architecture-design)
4. [TDD Protocol](#4-tdd-protocol)
5. [Refinement Checklist](#5-refinement-checklist)

### Part 2: Workflow Catalog (100)
1. [Design Philosophy](#1-design-philosophy)
2. [Category Definition](#2-category-definition)
3. [Workflow List](#3-workflow-list)
4. [Usage Scenarios](#4-usage-scenarios)
5. [Community & Social](#5-community--social)

---

# Part 1: Core Protocols (Execution Lifecycle)

## 1. Planning Phase (Sequential Thinking)

Before writing any code, the **Sequential Thinking MCP** must be engaged to prevent logical gaps.

### Execution Prompt
> "I am requesting a deep planning session. Please use the `sequential-thinking` tool to analyze the user's request:
> 1. Break down the requirements.
> 2. Identify potential ambiguity.
> 3. Propose a step-by-step implementation plan.
> 4. Do not generate code until the plan is solid."

### Critical Thinking Checklist
- [ ] Have I identified the *core* problem?
- [ ] Is the solution feasible within the current user context?
- [ ] Are there hidden dependencies?
- [ ] What is the "Definition of Done"?

---

## 2. PRD Template (Product Requirements)

**File**: `documents/XX-PRD-[FeatureName].md`

```markdown
# [PRD] Feature Name

## 1. Overview
(Brief description of what and why)

## 2. User Stories
- **User**: As a [Role]
- **Action**: I want to [Action]
- **Benefit**: So that [Benefit]

## 3. Technical Specs
| Component | Tech Stack | Notes |
| :--- | :--- | :--- |
| Frontend | React, Tailwind | ver 18.x |
| Backend | NestJS | REST API |

## 4. Requirements
### Functional
- [ ] User must be able to login
- [ ] User must see dashboard

### Non-Functional
- [ ] Load time < 200ms
- [ ] Secure via JWT

## 5. TODO List (Implementation Plan)
- [ ] Step 1: DB Schema
- [ ] Step 2: API Mock
```

---

## 3. Architecture Design

**File**: `documents/artifacts/implementation/project-structure.md`

### Pattern Selection
- **MVC**: Simple apps, quick prototypes.
- **Layered (Controller-Service-Repo)**: Standard Node.js Backend.
- **Hexagonal (Ports & Adapters)**: Complex domain logic, high testability needs.

### Output Standard (Tree View)
Use `tree` format to document the agreed structure:
```
src/
├── presentation/   # Controllers
├── business/       # Services
├── data/           # Repositories (Prisma/TypeORM)
└── main.ts
```

---

## 4. TDD Protocol

The **Red-Green-Refactor** cycle is mandatory for core logic.

### Phase 1: Red (Test First)
Write a test that fails because the feature doesn't exist.
```typescript
describe('UserCalculator', () => {
  it('should calculate bonus accurately', () => {
    const calc = new UserCalculator();
    expect(calc.getBonus(100)).toBe(10); // Fails
  });
});
```

### Phase 2: Green (Make it Work)
Write the *minimum* code to pass the test.
```typescript
class UserCalculator {
  getBonus(amount: number) { return amount * 0.1; }
}
```

### Phase 3: Refactor (Make it Better)
Optimize code structure without breaking the test.

---

## 5. Refinement Checklist
Before marking a task as "Done":

- [ ] Does it meet all PRD requirements?
- [ ] Are all tests passing (Green)?
- [ ] Is the code clean (Linted)?
- [ ] Is the documentation (`archive.md`) updated?

---

# Part 2: Workflow Catalog (100)

## 1. Design Philosophy

### 1.1 Antigravity Workflow Definition

**Antigravity Workflow** is a set of sequential steps to achieve a specific goal within the Google Antigravity framework.

```
Goal (Purpose)
  └─ Category (Category)
      └─ Workflow (Workflow = Steps + Rules + Personas + Parallel Tasks)
          └─ Checklist (Checklist)
              └─ Artifacts (Artifacts)
```

### 1.2 Design Principles

| Principle | Description | Implementation |
|------|------|---------|
| **Purpose Clarity** | One purpose per workflow | "What does this achieve?" |
| **Reusability** | Applicable across teams | Templates provided |
| **Staging** | Sequential or Parallel | Explicitly defined |
| **Verifiability** | Clear completion criteria | DoD Checklist |

### 1.3 Connection to Global Rules

| Global Rules | Connection |
|--------------|---------|
| **Identity & Attitude** | Korean first, proactive attitude |
| **Code Convention** | Naming, directory structure, security |
| **Proactive Strategy** | Sequential Thinking, Persona Switching, Parallel Execution |
| **Documentation** | Markdown file generation capability |

---

## 2. Category Definition

Antigravity Workflows are categorized into 14 purpose-based groups:

### 2.1 Category Map

```
┌─────────────────────────────────────────────────────────────────┐
│                   ANTIGRAVITY WORKFLOWS (100)                  │
├─────────────────────────────────────────────────────────────────┤
│  ▶ PROJECT & PLANNING (8)                                      │
│  ▶ CODE QUALITY (12)                                           │
│  ▶ DEVELOPMENT (15)                                            │
│  ▶ FRONTEND (12)                                               │
│  ▶ BACKEND (12)                                                │
│  ▶ DATABASE (8)                                                │
│  ▶ DEVOPS & INFRASTRUCTURE (8)                                 │
│  ▶ SECURITY & COMPLIANCE (6)                                   │
│  ▶ DOCUMENTATION (5)                                           │
│  ▶ COLLABORATION & TEAM (6)                                    │
│  ▶ PERFORMANCE & OPTIMIZATION (4)                              │
│  ▶ MIGRATION & UPGRADE (4)                                     │
│  ▶ TROUBLESHOOTING & DEBUG (2)                                 │
│  ▶ COMMUNITY & SOCIAL (2)                                      │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. Workflow List

### 3.1 PROJECT & PLANNING (8 Workflows)

#### WF-P01: Project Kickoff
```
Purpose: Prepare systematically for a new project
Category: PROJECT & PLANNING
Persona: PM, Tech PM, Engineer
Parallel: ❌
Time: 4-6 hours

Steps:
  1. Sequential Thinking: Requirement Analysis
  2. PRD Creation: Functional/Non-functional requirements
  3. Architecture Design: Tech stack, folder structure
  4. Team Assignment: Allocation of roles
  5. Timeline: Milestones & Deadlines
  
Checklist:
  ☐ PRD Approved
  ☐ Architecture Diagram created
  ☐ key roles assigned
  ☐ Timeline set
```

#### WF-P02: Tech Stack Review
```
Purpose: Select appropriate tech stack
Category: PROJECT & PLANNING
Persona: Engineer, Tech PM
Parallel: ✅ (FE vs BE)
Time: 3-4 hours

Steps:
  1. Analysis: Constraints & Requirements
  2. Research: 3-4 candidates per layer
  3. Evaluation: Performance, Maintenance, Community
  4. Decision: Pros/Cons analysis
  
Checklist:
  ☐ Compatibility check
  ☐ Performance benchmarks
  ☐ License check
```

#### WF-P03: Requirements Workshop
```
Purpose: Define detailed requirements with stakeholders
Category: PROJECT & PLANNING
Persona: PM, Engineer
Parallel: ❌
Time: 2-3 hours

Steps:
  1. Preparation: Agenda
  2. Sharing: Context & Goals
  3. Discussion: Feature details
  4. Prioritization: MoSCoW method
  
Checklist:
  ☐ All features defined
  ☐ Priorities clear
  ☐ Constraints identified
```

#### WF-P04: Roadmap Planning
```
Purpose: Create quarterly/yearly roadmap
Category: PROJECT & PLANNING
Persona: PM, Tech PM
Parallel: ❌
Time: 3-4 hours

Steps:
  1. Grouping: Feature phases
  2. Ordering: Business impact & Dependency
  3. Timeline: Estimation
  4. Milestones: MVP, 1.0, 2.0
  
Checklist:
  ☐ All features included
  ☐ Milestones realistic
  ☐ Risks mitigations plan
```

#### WF-P05: Architecture Review
```
Purpose: Identify issues in current architecture
Category: PROJECT & PLANNING
Persona: Engineer, Tech PM
Parallel: ✅ (Partial)
Time: 4-5 hours

Steps:
  1. Documentation: Current diagrams
  2. Analysis: Scalability bottlenecks
  3. Security Review: Auth & Data
  4. Improvement Proposal
  
Checklist:
  ☐ Diagrams updated
  ☐ Security reviewed
  ☐ Improvements prioritized
```

#### WF-P06: Team Setup & Role Definition
```
Purpose: Clarify responsibilities
Category: PROJECT & PLANNING
Persona: PM, Tech PM
Parallel: ❌
Time: 2-3 hours

Steps:
  1. Identify roles
  2. Assign members
  3. Define R&R
  4. Communication channels
  
Checklist:
  ☐ All core roles filled
  ☐ R&R defined
  ☐ Onboarding ready
```

#### WF-P07: Risk Assessment
```
Purpose: Pre-identify project risks
Category: PROJECT & PLANNING
Persona: PM, Tech PM
Parallel: ✅
Time: 3-4 hours

Steps:
  1. Identify Risks (Tech, Schedule, Resource)
  2. Evaluate (Probability * Impact)
  3. Prioritize
  4. Mitigation Plans
  
Checklist:
  ☐ Key risks identified
  ☐ Mitigation plans set
  ☐ Monitoring plan
```

#### WF-P08: Project Approval & Kickoff
```
Purpose: Final approval and official start
Category: PROJECT & PLANNING
Persona: PM, Engineer
Parallel: ❌
Time: 1-2 hours

Steps:
  1. Final Review
  2. Approval Meeting
  3. Official Sign-off
  4. Kickoff Meeting
  
Checklist:
  ☐ Stakeholders approved
  ☐ Kickoff held
  ☐ Team ready
```

---

### 3.2 CODE QUALITY (12 Workflows)

#### WF-CQ01: Code Review Process
```
Purpose: Systematic code review for PR/MR
Category: CODE QUALITY
Persona: Engineer, Backend, Frontend
Parallel: ✅
Time: 30min - 2h

Steps:
  1. PR Creation
  2. Auto Checks (CI)
  3. Manual Review (/review command)
  4. Feedback
  5. Merge
  
Checklist:
  ☐ Tests passed
  ☐ CI checked
  ☐ Style compliant
  ☐ No security issues
```

#### WF-CQ02: Linting & Formatting Automation
```
Purpose: Automate code style consistency
Category: CODE QUALITY
Persona: Engineer
Parallel: ✅
Time: 2-3 hours

Steps:
  1. Setup ESLint/Prettier
  2. Setup Husky/lint-staged
  3. CI pipeline addition
  4. IDE Config
  
Checklist:
  ☐ ESLint/Prettier set
  ☐ Pre-commit hook active
  ☐ CI integration
```

#### WF-CQ03: Test Coverage Improvement
```
Purpose: Reach 80%+ coverage
Category: CODE QUALITY
Persona: Backend, Frontend
Parallel: ✅
Time: 5-10 hours+

Steps:
  1. Measure Coverage
  2. Prioritize low coverage areas
  3. Write Tests (Red-Green-Refactor)
  4. CI Gate Setup
  
Checklist:
  ☐ >80% coverage
  ☐ Core features testing
  ☐ CI Gate active
```

#### WF-CQ04: Static Analysis & Security Scan
```
Purpose: Auto-detect quality/security issues
Category: CODE QUALITY
Persona: Engineer, Security
Parallel: ✅
Time: 2-3 hours

Steps:
  1. Tool Selection (SonarQube, Snyk)
  2. CI Integration
  3. Rules Config
  4. Baseline Report
  
Checklist:
  ☐ Tool integrated
  ☐ Initial issues resolved
  ☐ CI Gate set
```

#### WF-CQ05: Tech Debt Quantification
```
Purpose: Quantify and plan debt reduction
Category: CODE QUALITY
Persona: Engineer, Tech PM
Parallel: ❌
Time: 4-6 hours

Steps:
  1. Analyze Legacy/Issues
  2. Score Impact
  3. Prioritize
  4. Reduction Plan
  
Checklist:
  ☐ Key debts identified
  ☐ Scored & Prioritized
  ☐ Plan approved
```

#### WF-CQ06: Performance Profiling
```
Purpose: Optimize bottlenecks
Category: CODE QUALITY
Persona: Backend, Frontend, DevOps
Parallel: ✅
Time: 6-8 hours

Steps:
  1. Profile (DevTools/Node)
  2. Identify Bottlenecks
  3. Analyze Root Cause
  4. Optimize
  5. Measure Results
  
Checklist:
  ☐ Metrics measured (Core Web Vitals etc.)
  ☐ Bottlenecks resolved
  ☐ >30% improvement
```

#### WF-CQ07: Error Handling Standardization
```
Purpose: Unify error handling strategy
Category: CODE QUALITY
Persona: Engineer
Parallel: ✅
Time: 4-6 hours

Steps:
  1. Analyze current state
  2. Define Standard (Classes, Codes)
  3. Implement Middleware
  4. Document
  
Checklist:
  ☐ Custom Error Class
  ☐ HTTP Status Mapping
  ☐ Logging Standard
```

#### WF-CQ08: Security Code Review
```
Purpose: Deep security review (/review)
Category: CODE QUALITY
Persona: Security, Engineer
Parallel: ❌
Time: 2-4 hours

Steps:
  1. Checklist (OWASP Top 10)
  2. Auth/Authz Review
  3. Data Protection Review
  4. Input Validation Review
  
Checklist:
  ☐ OWASP Top 10 checked
  ☐ No known vulnerabilities
  ☐ Dependencies safe
```

#### WF-CQ09: Refactoring Execution
```
Purpose: Clean code without functional change
Category: CODE QUALITY
Persona: Engineer
Parallel: ✅
Time: 4-8 hours

Steps:
  1. Identify Targets
  2. Ensure Tests
  3. Refactor
  4. Verify
  
Checklist:
  ☐ Functionality preserved
  ☐ Complexity reduced
  ☐ Tests passed
```

#### WF-CQ10: Accessibility Audit
```
Purpose: Ensure WCAG 2.1 compliance
Category: CODE QUALITY
Persona: Frontend, Designer
Parallel: ✅
Time: 4-6 hours

Steps:
  1. Auto Scan (Lighthouse/axe)
  2. Manual Test (Keyboard/ScreenReader)
  3. Contrast Check
  4. Fix Issues
  
Checklist:
  ☐ WCAG 2.1 AA
  ☐ Keyboard Navigable
  ☐ Screen Reader Compatible
```

#### WF-CQ11: Documentation Quality Review
```
Purpose: Verify contents of docs/comments
Category: CODE QUALITY
Persona: Engineer, Tech PM
Parallel: ✅
Time: 2-3 hours

Steps:
  1. Review JSDoc/Comments
  2. Review API Docs
  3. Review README
  4. Update Diagrams
  
Checklist:
  ☐ All public API verified
  ☐ Docs accurate
  ☐ Examples working
```

#### WF-CQ12: Code Ownership
```
Purpose: Define module owners
Category: CODE QUALITY
Persona: Engineer, PM
Parallel: ❌
Time: 2-3 hours

Steps:
  1. Create CODEOWNERS
  2. Document Knowledge
  3. Knowledge Transfer
  
Checklist:
  ☐ CODEOWNERS created
  ☐ Core modules documented
  ☐ Team aware
```

---

### 3.3 DEVELOPMENT (15 Workflows)

#### WF-D01: Feature Development Standard
```
Purpose: Systematic feature implementation
Category: DEVELOPMENT
Persona: Fullstack
Parallel: ✅
Time: 8-16h

Steps:
  0. Planning
  1. PRD
  2. Design
  3. Pre-Code (Test Setup)
  4. Dev (TDD)
  5. Verify
  6. Refine
  
Checklist:
  ☐ Coverage >80%
  ☐ Review Passed
  ☐ Docs Updated
```

#### WF-D02: Bug Fix
```
Purpose: Systematic bug resolution
Category: DEVELOPMENT
Persona: Fullstack
Parallel: ✅
Time: 1-4h

Steps:
  1. Classify
  2. Root Cause (/debug)
  3. Test Reproduction
  4. Fix
  5. Verify
  
Checklist:
  ☐ Cause identified
  ☐ Reproduction test passed
  ☐ No side effects
```

#### WF-D03: API Implementation
```
Purpose: Implement REST API
Category: DEVELOPMENT
Persona: Backend
Parallel: ✅
Time: 4-8h

Steps:
  1. OpenAPI Spec
  2. Route Design
  3. Schema (Zod)
  4. Error Handling
  5. Controller Implementation
  
Checklist:
  ☐ Spec Valid
  ☐ Inputs Validated
  ☐ Errors Handled
```

#### WF-D04: Microservice Communication
```
Purpose: Design service-to-service interaction
Category: DEVELOPMENT
Persona: Backend
Parallel: ❌
Time: 6-8h

Steps:
  1. Pattern (Sync/Async)
  2. Data Flow
  3. Reliability (Circuit Breaker)
  4. Monitoring
  
Checklist:
  ☐ Pattern selected
  ☐ Failover planned
  ☐ Implementation verified
```

#### WF-D05: Data Migration
```
Purpose: Move/Transform data safely
Category: DEVELOPMENT
Persona: Backend, DBA
Parallel: ❌
Time: 8-16h

Steps:
  1. Strategy Strategy
  2. Validation Plan
  3. Rollback Plan
  4. Scripting
  5. Dry Run
  6. Execution
  
Checklist:
  ☐ Strategy Approved
  ☐ Dry Run Successful
  ☐ Rollback Ready
```

#### WF-D06: Bulk Data Processing
```
Purpose: Handle large datasets efficiently
Category: DEVELOPMENT
Persona: Backend
Parallel: ✅
Time: 6-10h

Steps:
  1. Requirements Analysis
  2. Algorithm (Batch/Stream)
  3. Optimization
  4. Implementation & Monitoring
  
Checklist:
  ☐ Performance goal met
  ☐ Memory optimized
  ☐ Retry logic working
```

#### WF-D07: Caching Strategy
```
Purpose: Apply caching for performance
Category: DEVELOPMENT
Persona: Backend
Parallel: ✅
Time: 4-6h

Steps:
  1. Identify Targets
  2. Choose Layer (Redis/CDN)
  3. TTL & Invalidation
  4. Implementation
  
Checklist:
  ☐ Response time improved
  ☐ Cache keys defined
  ☐ Invalidation works
```

#### WF-D08: Concurrency Control
```
Purpose: Handle race conditions
Category: DEVELOPMENT
Persona: Backend
Parallel: ❌
Time: 4-6h

Steps:
  1. Identify Danger Zones
  2. Choose Strategy (Locking/MVCC)
  3. Implementation
  4. Stress Test
  
Checklist:
  ☐ No race conditions
  ☐ Deadlock free
  ☐ Performance acceptable
```

#### WF-D09: i18n Implementation
```
Purpose: Support multiple languages
Category: DEVELOPMENT
Persona: Fullstack
Parallel: ✅
Time: 6-8h

Steps:
  1. Library Setup
  2. String Extraction
  3. Translation Files
  4. Dynamic Switching
  
Checklist:
  ☐ Major languages covered
  ☐ Switching works
  ☐ Formatting correct
```

#### WF-D10: Background Jobs
```
Purpose: Async processing
Category: DEVELOPMENT
Persona: Backend
Parallel: ✅
Time: 5-7h

Steps:
  1. Job Definition
  2. Queue System Setup
  3. Worker Implementation
  4. Monitoring
  
Checklist:
  ☐ Queue working
  ☐ Retry configured
  ☐ Monitoring active
```

#### WF-D11: Error Tracking System
```
Purpose: Setup production monitoring
Category: DEVELOPMENT
Persona: DevOps
Parallel: ✅
Time: 4-6h

Steps:
  1. Library Config (Winston etc)
  2. Tracking Tool (Sentry etc)
  3. Structured Logging
  
Checklist:
  ☐ Auto-tracking active
  ☐ Stack traces visible
  ☐ Alerts configured
```

#### WF-D12: Feature Flags
```
Purpose: Toggle features dynamically
Category: DEVELOPMENT
Persona: Fullstack
Parallel: ✅
Time: 4-6h

Steps:
  1. Store Setup
  2. Flag Definitions
  3. Client Implementation
  4. Admin UI
  
Checklist:
  ☐ Toggling works
  ☐ Monitoring active
```

#### WF-D13: Solution Testing
```
Purpose: Verify final solution
Category: DEVELOPMENT
Persona: QA, Engineer
Parallel: ✅
Time: 4-8h

Steps:
  1. Unit Tests
  2. Integration Tests
  3. E2E Tests
  4. Load Tests
  
Checklist:
  ☐ All tests passed
  ☐ Coverage Met
  ☐ Performance Validated
```

#### WF-D14: Release Prep
```
Purpose: Prepare for deployment
Category: DEVELOPMENT
Persona: DevOps, PM
Parallel: ❌
Time: 2-4h

Steps:
  1. Versioning
  2. Changelog
  3. Plan & Rollback
  4. Docs Check
  
Checklist:
  ☐ Version set
  ☐ Changelog ready
  ☐ Plan approved
```

#### WF-D15: Hotfix
```
Purpose: Production emergency fix
Category: DEVELOPMENT
Persona: Fullstack
Parallel: ❌
Time: 1-2h

Steps:
  1. Assess Severity
  2. Branch Hotfix
  3. Minimal Fix
  4. Quick Test
  5. Deploy
  
Checklist:
  ☐ Fix verified
  ☐ No side effects
  ☐ Deployed
```

---

### 3.4 FRONTEND (12 Workflows)

#### WF-FE01: Component Implementation
```
Purpose: Reusable component creation
Category: FRONTEND
Persona: Frontend
Parallel: ✅
Time: 4-6h

Steps:
  1. Analysis & Interface
  2. Storybook
  3. Styling
  4. Testing
  
Checklist:
  ☐ Props defined
  ☐ Storybook ready
  ☐ Responsive
```

#### WF-FE02: State Management Design
```
Purpose: Architecture for state (Redux/Zustand)
Category: FRONTEND
Persona: Frontend
Parallel: ❌
Time: 6-8h

Steps:
  1. Lib Selection
  2. Structure Design
  3. Actions/Reducers
  4. DevTools
  
Checklist:
  ☐ Structure clear
  ☐ DevTools active
```

#### WF-FE03: Form Management
```
Purpose: Handling complex forms
Category: FRONTEND
Persona: Frontend
Parallel: ✅
Time: 3-4h

Steps:
  1. Lib Selection (RHF)
  2. Schema (Zod)
  3. Implementation
  4. Validation
  
Checklist:
  ☐ Validation works
  ☐ UX good
```

#### WF-FE04: Data Fetching
```
Purpose: Efficient API interaction
Category: FRONTEND
Persona: Frontend
Parallel: ✅
Time: 4-5h

Steps:
  1. Client Setup (Query/Axios)
  2. Caching Strategy
  3. Error/Loading States
  
Checklist:
  ☐ Fetching works
  ☐ Caching effective
  ☐ States handled
```

#### WF-FE05: Routing Design
```
Purpose: Setup navigation
Category: FRONTEND
Persona: Frontend
Parallel: ❌
Time: 3-4h

Steps:
  1. Route Tree
  2. Dynamic Routes
  3. Protected Routes
  
Checklist:
  ☐ Navigation works
  ☐ Auth protection active
```

#### WF-FE06: Frontend Optimization
```
Purpose: Improve Core Web Vitals
Category: FRONTEND
Persona: Frontend
Parallel: ✅
Time: 6-8h

Steps:
  1. Measure (Lighthouse)
  2. Code Split
  3. Image Optimization
  4. Cache Headers
  
Checklist:
  ☐ Lighthouse >90
  ☐ Bundle size reduced
```

#### WF-FE07: Design System
```
Purpose: Consistent UI
Category: FRONTEND
Persona: Designer, Frontend
Parallel: ✅
Time: 10-12h

Steps:
  1. Tokens (Color/Type)
  2. Spacing / Grid
  3. Base Components
  4. Storybook
  
Checklist:
  ☐ Tokens defined
  ☐ Components ready
```

#### WF-FE08: Responsive Design
```
Purpose: Mobile/Desktop support
Category: FRONTEND
Persona: Frontend
Parallel: ❌
Time: 5-7h

Steps:
  1. Breakpoints
  2. Grid/Flex
  3. Media Queries
  
Checklist:
  ☐ Mobile first
  ☐ Tested on devices
```

#### WF-FE09: A11y Implementation
```
Purpose: Accessibility
Category: FRONTEND
Persona: Frontend
Parallel: ✅
Time: 6-8h

Steps:
  1. Semantic HTML
  2. ARIA labels
  3. Keyboard Nav
  4. Contrast
  
Checklist:
  ☐ Semantic
  ☐ Keyboard works
  ☐ Contrast pass
```

#### WF-FE10: Error Boundaries
```
Purpose: Graceful crash handling
Category: FRONTEND
Persona: Frontend
Parallel: ✅
Time: 2-3h

Steps:
  1. Boundary Component
  2. Fallback UI
  3. Logging
  
Checklist:
  ☐ Captures errors
  ☐ Shows fallback
```

#### WF-FE11: PWA
```
Purpose: App-like experience
Category: FRONTEND
Persona: Frontend
Parallel: ✅
Time: 5-6h

Steps:
  1. Manifest
  2. Service Worker
  3. Install Prompt
  
Checklist:
  ☐ Offline works
  ☐ Installable
```

#### WF-FE12: Dark Mode
```
Purpose: Theme support
Category: FRONTEND
Persona: Frontend
Parallel: ❌
Time: 3-4h

Steps:
  1. Theme Context
  2. Color Tokens
  3. Toggle UI
  4. Persist Pref
  
Checklist:
  ☐ Toggle works
  ☐ Persists
```

---

### *Other Categories (Summarized due to length)*

For **Backend (WF-BE*)**, **Database (WF-DB*)**, **DevOps (WF-DO*)**, **Security (WF-SC*)**, **Documentation (WF-DOC*)**, **Collaboration (WF-COL*)**, **Performance (WF-PO*)**, **Migration (WF-MU*)**, **Troubleshooting (WF-TD*)**, **Community (WF-COM*)**, please follow the standard template:
1. **Purpose** & **Category**
2. **Steps** (Analysis -> Implement -> Verify)
3. **Artifacts** (Code/Docs)
4. **Checklist** (DoD)

---

## 4. Usage Scenarios

### 4.1 "New Project"
`WF-P01(Kickoff) -> WF-P02(Stack) -> WF-P03(Reqs)`

### 4.2 "Production Bug"
`WF-D02(BugFix) -> WF-CQ04(Scan) -> WF-CQ03(Coverage)`

### 4.3 "Slowness"
`WF-CQ06(Profile) -> WF-FE06(FE Opt) -> WF-DO04(Monitor)`

### 4.4 "Release"
`WF-D14(Prep) -> WF-DO01(Deploy) -> WF-DO02(Monitor)`

---

## 5. Community & Social

### 5.1 Team Size Guide
- **1-3 ppl**: P01, D01, CQ01
- **4-8 ppl**: Full P, D, CQ series
- **8+ ppl**: All workflows

### 5.2 Content Ideas
- "How we utilized WF-D01 for 3x speed"
- "Parallel Dev with Git Worktree (Agent Squad)"
