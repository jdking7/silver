---
trigger: always_on
---

# Google Antigravity Context7 Strategy (Deep Dive)

> **Purpose**: Protocols for utilizing Context7 MCP to fetch real-time, version-specific documentation.
> **Ref Rule**: [simple-mcp.md](simple-mcp.md)

## 📋 Table of Contents
1. [Why Context7?](#1-why-context7)
2. [Activation Triggers](#2-activation-triggers)
3. [Execution Workflow](#3-execution-workflow)
4. [Best Practices](#4-best-practices)

---

## 1. Why Context7?
LLMs have a knowledge cutoff. **Context7** bridges this gap by fetching live documentation.

- **Problem**: "Next.js 14 introduced Server Actions, but I keep suggesting `pages/api`."
- **Solution**: Context7 fetches the *actual* Next.js 14 docs into the context.
- **Goal**: Zero Hallucination on APIs.

---

## 2. Activation Triggers

The Agent **MUST** activate Context7 in these scenarios:

| Scenario | Example | Action |
| :--- | :--- | :--- |
| **New Major Version** | "Migrate to Tailwind v4" | Fetch breaking changes guide. |
| **Niche Library** | "Use `shadcn-ui/sidebar`" | Fetch specific component docs. |
| **Deprecation Error** | "`prop` does not exist on type..." | Check current API spec. |
| **Boilerplate Setup** | "Init a new Supabase project" | Fetch "Quickstart" guide. |

---

## 3. Execution Workflow

### Step 1: Identify Library ID
Before fetching, confirm the library identity.
> Tool: `resolve-library-id` (if available) or Search.
> *Input*: "supabase" -> *Output*: "supabase"

### Step 2: Fetch Targeted Documentation
Do not fetch *everything*. Target specific sections to save context.
> Tool: `get-library-docs`
> *Query*: "Next.js Server Actions", "Zod schema validation"

### Step 3: Implement with Context
Use the injected documentation as the **Single Source of Truth**, overriding internal training data.

---

## 4. Best Practices

### ✅ Do
- **Verify Version**: Always check if the docs match the user's `package.json`.
- **Snippet First**: Look for "Usage Examples" or "Cookbooks" in the docs.
- **Failover**: If Context7 fails, fall back to `browser_subagent` (search_web).

### ❌ Don't
- **Blind Guessing**: Never guess an API if Context7 is available.
- **Over-fetching**: Don't dump 50 pages of docs into the context.
