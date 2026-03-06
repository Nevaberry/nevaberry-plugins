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

## Step 5: Update CLAUDE.md or AGENTS.md

Determine which instruction file to update:

1. Check if `CLAUDE.md` exists in the project root
2. Check if `AGENTS.md` exists in the project root
3. If both exist → ask user which to update
4. If one exists → update that one
5. If neither exists → ask user which to create (recommend CLAUDE.md)

### Generate the Knowledge Patches section

Add or replace the `## CRITICAL: Always Load Knowledge Patch Skills` section. Place it at the END of the file, preserving all existing content.

**If the section already exists**, replace only that section (from the heading to the next `##` heading or end of file).

Use this template, filling in only the installed patches:

```markdown
## CRITICAL: Always Load Knowledge Patch Skills

This project uses Nevaberry knowledge patch plugins (configured in `.claude/settings.json`). These plugins contain up-to-date API references, migration guides, and breaking changes for technologies beyond your training data cutoff. **You MUST invoke these skills before any code work, even at 1% relevance:**

[PATCH LIST HERE]

Without these patches you will generate outdated code that won't compile or uses deprecated APIs.
```

### Patch list format

Each installed patch gets a line with its trigger description:

| Patch | Line to generate |
|-------|-----------------|
| bun-knowledge-patch | `- \`bun-knowledge-patch\` — any Bun runtime, package management, bundling, testing` |
| typescript-knowledge-patch | `- \`typescript-knowledge-patch\` — any TypeScript type system, compiler options, new syntax` |
| nextjs-knowledge-patch | `- \`nextjs-knowledge-patch\` — any Next.js routing, App Router, server actions, caching` |
| nodejs-knowledge-patch | `- \`nodejs-knowledge-patch\` — any Node.js APIs, built-in modules, runtime features` |
| python-knowledge-patch | `- \`python-knowledge-patch\` — any Python 3.13+ features, typing, standard library` |
| rust-knowledge-patch | `- \`rust-knowledge-patch\` — any Rust 2025 edition, new language features, std library` |
| dioxus-knowledge-patch | `- \`dioxus-knowledge-patch\` — any Dioxus components, signals, RSX, fullstack` |
| postgresql-knowledge-patch | `- \`postgresql-knowledge-patch\` — any PostgreSQL queries, MERGE, JSON functions, extensions` |
| postgis-knowledge-patch | `- \`postgis-knowledge-patch\` — any spatial queries, geography types, GIS functions` |

## Step 6: Show Summary

Show the user a completion summary:

```
Knowledge patch setup complete:

  Installed patches:
    - bun-knowledge-patch
    - typescript-knowledge-patch

  Settings file: .claude/settings.json
  Updated: CLAUDE.md

  Restart your Claude Code session for patches to take effect.
```

## Important Notes

- This command is idempotent — running it again updates existing configuration
- Existing patches in settings are preserved; new ones are added alongside them
- The CLAUDE.md section is replaced entirely to reflect the current set of patches
