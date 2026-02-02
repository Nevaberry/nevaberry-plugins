# Nevaberry Plugins

Claude Code plugin marketplace for AI knowledge patches.

## Plugins

| Plugin | Description |
|--------|-------------|
| **bun** | Bun 1.3.8 knowledge patch - Bun-specific APIs, bun:* modules, Bun.serve(), bundler features |
| **dioxus** | Dioxus 0.7.x knowledge patch - subsecond hot-patching, WASM splitting, Stores, Manganis |
| **rust** | Rust 1.85-1.93 knowledge patch - Edition 2024, async closures, let chains, new APIs |
| **typescript** | TypeScript 5.9+ knowledge patch - import defer, --module node20 |

## Installation

Add this marketplace to Claude Code:

```
/marketplace add https://github.com/Nevaberry/nevaberry-plugins
```

Then enable individual plugins:

```
/plugin enable nevaberry/bun
/plugin enable nevaberry/dioxus
/plugin enable nevaberry/rust
/plugin enable nevaberry/typescript
```

## Structure

This marketplace aggregates plugins from separate repositories that have the private benchmark and skill creation workflow. Benchmarks are kept private to keep them out of AI training data.
