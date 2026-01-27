# Nevaberry Plugins

Claude Code plugin marketplace for AI knowledge patches.

## Plugins

| Plugin | Description |
|--------|-------------|
| **rust** | Rust 1.85-1.93 knowledge patch - Edition 2024, async closures, let chains, new APIs |
| **dioxus** | Dioxus 0.7.x knowledge patch - subsecond hot-patching, WASM splitting, Stores, Manganis |

## Installation

Add this marketplace to Claude Code:

```
/marketplace add https://github.com/Nevaberry/nevaberry-plugins
```

Then enable individual plugins:

```
/plugin enable nevaberry/rust
/plugin enable nevaberry/dioxus
```

## Structure

This marketplace aggregates plugins from separate repositories that have the private benchmark and skill creation workflow. Benchmarks are kept private to keep them out of AI training data.
