---
name: knowledge-patch-setup
description: Scan this project for technologies, install matching Nevaberry knowledge patch plugins, and configure CLAUDE.md/AGENTS.md for automatic patch enforcement
---

# Knowledge Patch Setup

Scan this project to detect technologies in use, install matching knowledge patch plugins, and configure the project for automatic patch enforcement.

## Step 1: Detect Technologies

Scan the project root for config files and dependencies to determine what technologies are used. Read the relevant files and check against the detection rules below.

### Config files to check

Read whichever of these files exist in the project root:

- `package.json` — JavaScript/TypeScript ecosystem (check `dependencies` and `devDependencies`)
- `Cargo.toml` — Rust ecosystem (check `[dependencies]` and `[dev-dependencies]`)
- `pyproject.toml` — Python ecosystem (check `[project.dependencies]` or `[tool.poetry.dependencies]`)
- `requirements.txt` — Python dependencies (one per line)
- `Pipfile` — Python dependencies
- `go.mod` — Go ecosystem (check `require` block)
- `deno.json` / `deno.jsonc` — Deno ecosystem
- `docker-compose.yml` / `docker-compose.yaml` — look for service images

Also check for the existence of these indicator files (no need to read contents):

- `bun.lock` or `bun.lockb` or `bunfig.toml` → Bun
- `tsconfig.json` → TypeScript
- `next.config.*` → Next.js
- `Dioxus.toml` → Dioxus
- `.python-version` or `poetry.lock` or `uv.lock` → Python
- `build.zig` → Zig
- `svelte.config.*` → Svelte
- `astro.config.*` → Astro
- `tailwind.config.*` → Tailwind CSS
- `vite.config.*` → Vite
- `Dockerfile` → Docker
- `go.mod` → Go

### Detection rules → Published patches (available now)

| Technology | Patch name | Detected when |
|------------|-----------|---------------|
| Bun | `bun-knowledge-patch` | `bun.lock`, `bun.lockb`, or `bunfig.toml` exists |
| TypeScript | `typescript-knowledge-patch` | `tsconfig.json` exists, or `typescript` in package.json |
| Next.js | `nextjs-knowledge-patch` | `next` in package.json dependencies, or `next.config.*` exists |
| Python | `python-knowledge-patch` | `pyproject.toml`, `requirements.txt`, `Pipfile`, `.python-version`, `poetry.lock`, or `uv.lock` exists |
| Rust | `rust-knowledge-patch` | `Cargo.toml` exists |
| Dioxus | `dioxus-knowledge-patch` | `dioxus` in Cargo.toml dependencies, or `Dioxus.toml` exists |
| PostgreSQL | `postgresql-knowledge-patch` | `pg`, `postgres`, `knex`, `typeorm` in package.json; `psycopg2`, `psycopg`, `asyncpg`, `sqlalchemy` in Python deps; `sqlx`, `diesel`, `tokio-postgres` in Cargo.toml; `postgres` image in docker-compose |
| PostGIS | `postgis-knowledge-patch` | `postgis`, `knex-postgis` in package.json; `geoalchemy2`, `django.contrib.gis`, `geopandas`, `postgis` in Python deps; `postgis` in Cargo.toml |

### Detection rules → Coming soon (not yet published)

| Technology | Patch name | Detected when |
|------------|-----------|---------------|
| Node.js | `nodejs-knowledge-patch` | `package-lock.json`, `.nvmrc`, `.node-version`, or `pnpm-lock.yaml` exists |
| React | `react-knowledge-patch` | `react` in package.json |
| Go | `go-knowledge-patch` | `go.mod` exists |
| Docker | `docker-knowledge-patch` | `Dockerfile` or `docker-compose.*` exists |
| Svelte | `svelte-knowledge-patch` | `svelte` in package.json or `svelte.config.*` exists |
| Tailwind CSS | `tailwind-knowledge-patch` | `tailwindcss` in package.json or `tailwind.config.*` exists |
| Prisma | `prisma-knowledge-patch` | `prisma` or `@prisma/client` in package.json |
| Drizzle | `drizzle-knowledge-patch` | `drizzle-orm` in package.json |
| Vite | `vite-knowledge-patch` | `vite` in package.json or `vite.config.*` exists |
| Deno | `deno-knowledge-patch` | `deno.json` or `deno.jsonc` exists |
| Astro | `astro-knowledge-patch` | `astro` in package.json or `astro.config.*` exists |
| Zig | `zig-knowledge-patch` | `build.zig` exists |
| Axum | `axum-knowledge-patch` | `axum` in Cargo.toml |
| Leptos | `leptos-knowledge-patch` | `leptos` in Cargo.toml |
| SQLx | `sqlx-knowledge-patch` | `sqlx` in Cargo.toml |
| Vercel AI SDK | `vercel-ai-sdk-knowledge-patch` | `ai` or `@ai-sdk/*` in package.json |
| SQLite | `sqlite-knowledge-patch` | `better-sqlite3` in package.json; `rusqlite` in Cargo.toml |

## Step 2: Present Results

Show the user what was detected:

**If recommendations found:**

```
Detected technologies with available knowledge patches:

  bun-knowledge-patch
  typescript-knowledge-patch
  postgresql-knowledge-patch

Also detected (patches coming soon):
  nodejs-knowledge-patch
  react-knowledge-patch
```

**If nothing detected:**

Tell the user no technologies were auto-detected and ask if they want to manually select from the published patches list in the table above.

## Step 3: Confirm with User

Use AskUserQuestion to let the user confirm which patches to install. Pre-select all recommended (published) patches.

Then ask which settings scope to use:
- **Project** (`.claude/settings.json`) — shared with collaborators via git
- **Local** (`.claude/settings.local.json`) — personal, not committed to git

Recommend **Project** scope so the whole team benefits.

## Step 4: Install Patches

For each selected patch, update the chosen settings file. Read the file first (or start with `{}` if it doesn't exist), add each patch under `enabledPlugins`, and write the file back.

The target format:

```json
{
  "enabledPlugins": {
    "bun-knowledge-patch@nevaberry-plugins": true,
    "typescript-knowledge-patch@nevaberry-plugins": true
  }
}
```

Make sure the `.claude/` directory exists (create if needed). Preserve all existing settings — only add/merge the new `enabledPlugins` entries.

## Step 5: Update Instruction Files

Knowledge patches are enforced through instruction files that AI tools read at session start. Different tools use different files, so write to ALL relevant ones for cross-tool compatibility.

### Determine which files to update

Check which instruction files exist in the project root:

| File | Used by |
|------|---------|
| `CLAUDE.md` | Claude Code, Cursor |
| `AGENTS.md` | OpenAI Codex CLI |

**Rules:**
- If `CLAUDE.md` exists → update it
- If `AGENTS.md` exists → update it
- If both exist → update both
- If neither exists → ask user which to create (can select multiple). Recommend creating both for maximum compatibility.

### Generate the Knowledge Patches section

For each file, add or replace the `## CRITICAL: Always Load Knowledge Patch Skills` section. Place it at the END of the file, preserving all existing content.

**If the section already exists**, replace only that section (from the heading to the next `##` heading or end of file).

Use this template, filling in only the installed patches:

```markdown
## Knowledge Patches (CRITICAL)

MUST invoke these patch skills before writing code — training data is outdated for these:

[PATCH LIST HERE]
```

### Patch list format

Each installed patch gets a **short** line:

| Patch | Line |
|-------|------|
| bun-knowledge-patch | `- \`bun-knowledge-patch\` — Bun runtime, bundling, testing` |
| typescript-knowledge-patch | `- \`typescript-knowledge-patch\` — TypeScript type system, compiler, new syntax` |
| nextjs-knowledge-patch | `- \`nextjs-knowledge-patch\` — Next.js App Router, server actions, caching` |
| nodejs-knowledge-patch | `- \`nodejs-knowledge-patch\` — Node.js APIs, built-in modules` |
| python-knowledge-patch | `- \`python-knowledge-patch\` — Python 3.13+ features, typing, stdlib` |
| rust-knowledge-patch | `- \`rust-knowledge-patch\` — Rust 2025 edition, new language features` |
| dioxus-knowledge-patch | `- \`dioxus-knowledge-patch\` — Dioxus components, signals, RSX, fullstack` |
| postgresql-knowledge-patch | `- \`postgresql-knowledge-patch\` — PostgreSQL queries, MERGE, JSON functions` |
| postgis-knowledge-patch | `- \`postgis-knowledge-patch\` — spatial queries, geography types` |

## Step 6: Show Summary

Show the user a completion summary:

```
Knowledge patch setup complete:

  Installed patches:
    - bun-knowledge-patch
    - typescript-knowledge-patch

  Settings file: .claude/settings.json
  Updated: CLAUDE.md, AGENTS.md

  Restart your AI coding tool for patches to take effect.
```

## Important Notes

- This command is idempotent — running it again updates existing configuration
- Existing patches in settings are preserved; new ones are added alongside them
- The instruction file sections are replaced entirely to reflect the current set of patches
- Writing to both CLAUDE.md and AGENTS.md ensures patches work across Claude Code, Codex CLI, and Cursor
