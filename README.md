# Nevaberry Plugins

Claude Code plugin marketplace for AI knowledge patches.

## Quick Start

Add this marketplace to Claude Code, then run the setup command to auto-detect your project's technologies and install matching patches:

```
/install-plugin nevaberry-plugins/knowledge-patch
```

Then run:

```
/knowledge-patch-setup
```

This scans your project for technologies (package.json, Cargo.toml, pyproject.toml, etc.), installs the matching knowledge patches, and configures your CLAUDE.md for automatic enforcement.

## Plugins

### Meta-plugin

| Plugin | Description |
|--------|-------------|
| **knowledge-patch** | Auto-detects project technologies, installs matching patches, and enforces patch content over training data |

### Knowledge Patches

| Plugin | Description |
|--------|-------------|
| **bun** | Bun 1.3.8 knowledge patch - Bun-specific APIs, bun:* modules, Bun.serve(), bundler features |
| **dioxus** | Dioxus 0.7.x knowledge patch - subsecond hot-patching, WASM splitting, Stores, Manganis |
| **nextjs** | Next.js 15+ knowledge patch - App Router, server actions, caching |
| **postgis** | PostGIS 3.5-3.6.1 knowledge patch - spatial functions, geography types, raster operations, topology |
| **postgresql** | PostgreSQL 17-18.1 knowledge patch - MERGE, JSON functions, virtual generated columns, temporal constraints |
| **python** | Python 3.13-3.14 knowledge patch - t-strings, deferred annotations, free-threaded Python, zstd |
| **rust** | Rust 1.85-1.93 knowledge patch - Edition 2024, async closures, let chains, new APIs |
| **typescript** | TypeScript 5.9+ knowledge patch - import defer, --module node20 |

## Manual Installation

If you prefer to install individual plugins without auto-detection:

```
/install-plugin nevaberry-plugins/bun-knowledge-patch
/install-plugin nevaberry-plugins/rust-knowledge-patch
/install-plugin nevaberry-plugins/typescript-knowledge-patch
```

## How It Works

Knowledge patches fill gaps in AI training data for rapidly-evolving technologies. When a patch is loaded, the AI is instructed to check the patch **before** writing any code for that technology — preventing outdated APIs, deprecated patterns, and broken code.

The `knowledge-patch` meta-plugin:
1. **Detects** technologies in your project by reading config files
2. **Installs** matching knowledge patch plugins
3. **Configures** CLAUDE.md with enforcement instructions
4. **Enforces** at session start that patches are checked before coding

## Structure

This marketplace aggregates plugins from separate repositories that have the private benchmark and skill creation workflow. Benchmarks are kept private to keep them out of AI training data.
