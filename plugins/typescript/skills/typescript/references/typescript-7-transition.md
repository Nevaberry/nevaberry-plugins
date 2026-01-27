# TypeScript 6.0 & 7.0 Transition Guide

TypeScript 6.0 is the **last JavaScript-based release**. TypeScript 7.0 is a complete rewrite in Go, delivering ~10x performance improvements.

## TypeScript 7 Preview (tsgo)

### Installation

```bash
npm install -D @typescript/native-preview
npx tsgo --project ./tsconfig.json
```

### VS Code Setup

1. Install "TypeScript (Native Preview)" extension from Marketplace
2. Enable: `"typescript.experimental.useTsgo": true`

### Current Capabilities

**Working:**
- Type-checking (near parity with TS6)
- Completions with auto-imports
- Go-to-definition, go-to-type-definition, go-to-implementation
- Find-all-references
- Rename
- Signature help
- Hover tooltips
- `--incremental` mode
- `--build` mode with multi-project parallelism
- Project references

**Limited:**
- Emit targets `es2021` minimum
- No decorator emit
- Watch mode less efficient (use `nodemon` with `--incremental`)
- No stable API for tooling

### Performance

| Project | TypeScript 6.0 | tsgo 7.0 | Speedup |
|---------|----------------|----------|---------|
| VS Code | 89.11s | 8.74s | 10.2x |
| Sentry | 133.08s | 16.25s | 8.2x |

## TypeScript 6.0 Breaking Changes

These features are deprecated in TS6 and **removed in TS7**:

| Removed | Migration |
|---------|-----------|
| `--strict` optional | Now default, remove the flag |
| `--target` pre-ES2015 | Minimum `es2015`, default `es2025` |
| `--baseUrl` | Use `paths` with explicit mappings |
| `node10` moduleResolution | Use `node16`, `nodenext`, or `bundler` |
| `rootDir` implicit behavior | Explicit `rootDir` required |
| `@enum`, `@constructor` JSDoc | Use TypeScript syntax instead |

### Migration Tool

Automatically updates tsconfig.json for TS6 compatibility:

```bash
npx ts5to6
```

## Recommended Configuration

### For TypeScript 7 / tsgo

```json
{
  "compilerOptions": {
    "module": "preserve",
    "moduleResolution": "bundler"
  }
}
```

### Modern Defaults (tsc --init in 5.9+)

```json
{
  "compilerOptions": {
    "target": "esnext",
    "module": "nodenext",
    "strict": true,
    "moduleDetection": "force",
    "noUncheckedSideEffectImports": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true
  }
}
```

## Timeline

- **TypeScript 6.0**: Last JS-based release, only patch releases thereafter
- **Mid-2025**: tsgo preview for CLI typechecking
- **End 2025**: Feature-complete language service
- **TypeScript 7.0**: Full native release (date TBD)

## Source

- https://github.com/microsoft/typescript-go
- https://devblogs.microsoft.com/typescript/typescript-native-port/
- https://devblogs.microsoft.com/typescript/progress-on-typescript-7-december-2025/
