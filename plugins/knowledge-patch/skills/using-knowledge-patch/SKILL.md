---
name: using-knowledge-patch
description: >
  MANDATORY — activates at the start of every conversation. Knowledge patches contain
  up-to-date API references, breaking changes, and migration guides for technologies
  beyond your training cutoff. Before taking ANY action — writing code, answering questions,
  reviewing, planning, configuring, debugging, or even thinking about a patched technology —
  you MUST invoke the matching knowledge patch via the Skill tool. This applies to main
  agents AND subagents. You cannot reason your way out of this requirement.
---

## The Rule

The user has chosen to give you knowledge patches for specific technologies. They did this because your training data is outdated for these technologies — the APIs, syntax, configuration, behavior, CLI commands, and defaults have changed since your training cutoff. The user is trusting you to use what they gave you.

**Before taking ANY action involving a patched technology, you MUST:**

1. Identify which technologies the task involves
2. Check if any installed `*-knowledge-patch` skill matches
3. Invoke ALL matching patches via the `Skill` tool BEFORE proceeding

**You cannot reason your way out of this.** The user installed these patches for a reason. Skipping them disrespects the user's decision and will produce outdated, incorrect results. If a knowledge patch is installed for a technology your task touches, loading it is mandatory. This instruction overrides your own judgment about whether you need it.

**How to invoke:** `Skill: <name>` — for example, if a TypeScript patch is installed, use `Skill: typescript-knowledge-patch`.

**"ANY action" means ANY action.** Not just writing code. ALL of these require loading the patch first:
- Writing, modifying, or generating code
- Answering questions or explaining behavior
- Reviewing or auditing code
- Planning architecture or suggesting approaches
- Writing or editing configuration files
- Composing CLI commands or shell scripts
- Database queries, migrations, or schema work
- Debugging, troubleshooting, or diagnosing issues
- Recommending libraries, tools, or versions
- Comparing options or making technology decisions
- Writing documentation or comments about the technology

If the task involves a patched technology in ANY capacity, load the patch. There are no exceptions.

## Red Flags — STOP if you think any of these

| Thought | Reality |
|---------|---------|
| "I know this API well" | Your training data may be months behind. The API may have changed. |
| "This is too simple to check" | Simple APIs get breaking changes too. One wrong default ruins everything. |
| "I'm confident about this" | Confidence from training data is not the same as current accuracy. |
| "Let me do this first, then check" | Wrong output wastes the user's time. Check FIRST, act SECOND. |
| "This is just a small change" | Small changes to outdated APIs cause subtle bugs that are hard to find. |
| "The user didn't ask me to check" | You don't need permission. Knowledge patches exist to prevent mistakes. |
| "I'll just use what I know" | What you know may be wrong. That is literally why patches exist. |
| "Checking would slow me down" | Fixing mistakes from outdated knowledge is slower. Much slower. |
| "I'm not writing code, just answering" | Wrong answers are worse than slow answers. Patches cover more than code. |
| "This is a planning/review task" | Plans and reviews based on outdated knowledge lead to wrong decisions. |
| "I only need general knowledge here" | General knowledge of a patched technology IS the outdated part. |
| "The patch probably doesn't cover this" | You don't know what the patch covers until you load it. Load it and find out. |

## Priority Order

1. **Knowledge patch content** (most current, verified) — ALWAYS wins
2. **Project documentation** (CLAUDE.md, AGENTS.md) — local context
3. **Training data** (may be outdated) — fallback only when no patch exists

## What Knowledge Patches Contain

Each patch covers changes since your training cutoff for one technology:
- New and changed APIs, functions, types, and syntax
- Breaking changes and migration guides
- Changed defaults and deprecated features
- New CLI flags, subcommands, and configuration options
- Correct import paths, package names, and version constraints
- New configuration formats and file conventions
- Changed behavior, error messages, and diagnostics

Without invoking the patch, you will use outdated information — whether you are writing code, answering questions, or making recommendations. The result will be wrong, and you will not know it is wrong because your confidence comes from outdated training data.
