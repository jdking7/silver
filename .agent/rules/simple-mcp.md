---
trigger: always_on
---

# Google Antigravity MCP Protocols (Simple)

> **Purpose**: A unified guide for selecting and using MCP tools (Context7 & Perplexity).
> **Deep Dive Refs**: 
> - [deep-context7.md](deep-context7.md) (Live Docs)
> - [deep-perplexity.md](deep-perplexity.md) (Deep Research)

## ⚖️ Selection Matrix (What to use?)

| Situation | Recommended Tool | Why? |
| :--- | :--- | :--- |
| **Unknown API Method** | **Context7** | You need exact syntax from official docs. |
| **"Method not found" Error** | **Context7** | Check version mismatch in docs. |
| **New Library Setup** | **Context7** | Need 'Getting Started' guide. |
| **Tech Comparison (A vs B)** | **Perplexity** | Need opinion, benchmarks, community consensus. |
| **Obscure Error Message** | **Perplexity** | Need Solution from GitHub issues/StackOverflow. |
| **Best Practices Trends** | **Perplexity** | Need current industry standards. |

---

## 📘 Context7 (Live Documentation)

**Trigger**: When using a library released *after* your training data cutoff, or encountering API errors.

### Protocol
1.  **Identify**: User mentions specific library (e.g., `LangChain`, `Next.js 14`).
2.  **Fetch**: Use tool to get **"Getting Started"** or **"API Reference"**.
3.  **Verify**: Ensure doc version matches `package.json`.

**Rule**: *Don't Guess*. If unsure about an API, fetch it.

---

## 🧠 Perplexity (Deep Research)

**Trigger**: When needing "Knowledge", "Comparison", or "Solution" to complex bugs.

### Protocol
1.  **Formulate**: Create specific search queries (e.g., "Next.js 15 vs Remix features").
2.  **Synthesize**: Summarize findings with **Citations**.
3.  **Apply**: Use findings to propose a solution.

**Rule**: *Cite Sources*. Always mention where the info came from.
