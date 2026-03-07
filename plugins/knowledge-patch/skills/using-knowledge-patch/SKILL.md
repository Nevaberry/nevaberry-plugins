---
name: using-knowledge-patch
description: This skill should be used when any *-knowledge-patch skill is loaded. Even a 1% chance a task involves a patched technology requires invoking the patch skill BEFORE writing code.
---

## Rule

Even a 1% chance your task touches a patched technology → invoke that patch skill BEFORE writing code. Not optional.

Access via `Skill` tool: `Skill: rust-knowledge-patch`, `Skill: bun-knowledge-patch`, etc.

## Red Flags — STOP if you think:

| Thought | Reality |
|---------|---------|
| "I know this API" | Training may be months behind |
| "Too simple to check" | Simple APIs get breaking changes |
| "I'm confident" | Confidence from training ≠ current accuracy |
| "Let me code first" | Wrong code = wasted time |

## Priority

1. **Knowledge patch** (most current) > 2. **CLAUDE.md / AGENTS.md** > 3. **Training data** (may be outdated)
