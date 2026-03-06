---
name: using-knowledge-patches
description: This skill should be used when starting any session with knowledge patches loaded, or when there is even a 1% chance a task involves a technology with a loaded knowledge patch. Covers "Bun", "TypeScript", "Next.js", "Python", "Rust", "Dioxus", "PostgreSQL", "PostGIS" and any technology with a loaded *-knowledge-patch plugin.
---

If there is even a 1% chance your task involves a technology with a loaded knowledge patch, you ABSOLUTELY MUST invoke that patch skill BEFORE writing any code.

IF A KNOWLEDGE PATCH EXISTS FOR A TECHNOLOGY YOU ARE WORKING WITH, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.

This is not negotiable. This is not optional. You cannot rationalize your way out of this.

## What Are Knowledge Patches?

Knowledge patches fill gaps in your training data for rapidly-evolving technologies. They contain:

- **New APIs and syntax** released after your training cutoff
- **Breaking changes** that make your training data dangerous
- **Migration guides** for moving between versions
- **Correct patterns** replacing deprecated approaches

Without patches, you WILL generate outdated, broken, or deprecated code.

## The Rule

**Invoke the relevant patch skill BEFORE writing any code for a patched technology.** Even a 1% chance the patch might be relevant means you MUST invoke it. If it turns out not to apply, you lose nothing. If you skip it and it did apply, you generate broken code.

## How to Access Patches

Use the `Skill` tool to invoke any knowledge patch that was listed at session start. The patch name is the skill name:

```
Skill: bun-knowledge-patch
Skill: typescript-knowledge-patch
```

Read the patch content before implementing features in the covered technology.

## Red Flags

These thoughts mean STOP — you're about to use outdated information:

| Dangerous Thought | Reality |
|-------------------|---------|
| "I know this API well" | Your training may be months/years behind |
| "This is a simple feature" | Simple features get breaking changes too |
| "I'll just use what I remember" | What you remember may be deprecated |
| "Let me just write the code quickly" | Quick + wrong = wasted time. Check first. |
| "I'm confident about this" | Confidence from training does not equal current accuracy |
| "I need more context first" | Patch check comes BEFORE exploration |

## Priority Order

When multiple information sources conflict:

1. **Knowledge patch content** (highest priority — most current)
2. **Project CLAUDE.md instructions** (project-specific guidance)
3. **Your training data** (lowest priority — may be outdated)

Patches always win over training data. No exceptions.

## The Flow

```
Task received
  → Does it involve a patched technology? (even 1% chance)
    → YES: Invoke the patch skill FIRST, then proceed
    → NO: Proceed normally
```

Do NOT:
- Write code first and check patches later
- Assume you remember the current API
- Skip the patch because the task seems simple
- Rationalize that "this part hasn't changed"
