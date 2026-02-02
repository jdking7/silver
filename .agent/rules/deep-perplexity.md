---
trigger: always_on
---

# Google Antigravity Perplexity Strategy (Deep Dive)

> **Purpose**: Protocols for utilizing Perplexity Ask MCP for deep research, comparative analysis, and obscure debugging.
> **Ref Rule**: [simple-mcp.md](simple-mcp.md)

## 📋 Table of Contents
1. [Context7 vs. Perplexity](#1-context7-vs-perplexity)
2. [Activation Triggers](#2-activation-triggers)
3. [Research Workflow](#3-research-workflow)
4. [Prompting Strategy](#4-prompting-strategy)

---

## 1. Context7 vs. Perplexity (When to use what?)

| Feature | Context7 (Live Docs) | Perplexity Ask (Deep Research) |
| :--- | :--- | :--- |
| **Primary Goal** | **Exact API Syntax** | **Broad Understanding & Solutions** |
| **Source** | Official Documentation | Entire Web (StackOverflow, Blogs, Docs) |
| **Scenario** | "What is the props for Button component?" | "Which UI library is best for Dashboard?" |
| **Result** | Raw Markdown / Code | Synthesized Answer with Citations |

**Rule of Thumb**:
- If you need **CODE** details -> **Context7**.
- If you need **KNOWLEDGE** or **CHOICE** -> **Perplexity**.

---

## 2. Activation Triggers

The Agent **MUST** activate Perplexity in these scenarios:

| Scenario | Example | Action |
| :--- | :--- | :--- |
| **Tech Selection** | "Should I use Prisma or TypeORM?" | Research latest benchmarks & pros/cons. |
| **Obscure Bug** | "Error: Hydration failed because..." | Search for community solutions & GitHub issues. |
| **Best Practices** | "How to structure a Monorepo in 2025" | Find recent articles and industry standards. |
| **Trend Analysis** | "Is tRPC still popular?" | Check usage trends and community sentiment. |

---

## 3. Research Workflow

### Step 1: Formulate the Core Question
Don't just pass the user's query. Refine it for a search engine.
> *User*: "My app is slow."
> *Query*: "Next.js performance optimization checklist for server-side rendering"

### Step 2: Cross-Verification
If Perplexity provides a solution (e.g., config change), verify it against official docs (Context7) if possible.

### Step 3: Synthesis
Provide the user with a summarized answer, including:
- **Direct Answer**: "Use Prisma because..."
- **Citations**: "According to [Source]..."
- **Actionable Step**: "Here is the config you need..."

---

## 4. Prompting Strategy (for the Agent)

When calling Perplexity, use the `sonar` models effectively:
- **Be Specific**: Include version numbers ("Next.js 15", "Python 3.12").
- **Ask for Code**: "Provide a code example for..."
- **Limit Scope**: "Focus on performance impact only."
