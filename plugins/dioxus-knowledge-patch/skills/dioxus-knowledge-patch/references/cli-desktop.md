# CLI and Desktop Configuration

## CLI Commands

```bash
dx new myapp              # Create new project
dx serve                  # Dev server with hot-reload
dx serve --platform web   # Specific platform
dx build --release        # Production build
dx bundle                 # Package for distribution
dx check                  # Lint RSX
dx fmt                    # Format RSX
dx translate              # Convert HTML to RSX
```

## Mobile CLI (0.6+)

First-class iOS/Android support:

```bash
dx serve --platform ios      # iOS simulator
dx serve --platform android  # Android emulator
dx bundle --platform android # Build .apk
```

## Platform-Specific Args

Use `@client` and `@server` to pass different features/args to each build:

```bash
dx serve @client --features web @server --features server
dx build @client --release @server --features production
```

## Desktop Configuration

### Launch with Config

```rust
use dioxus::desktop::{Config, WindowBuilder, LogicalSize};

fn main() {
    dioxus::LaunchBuilder::new()
        .with_cfg(
            Config::new()
                .with_window(
                    WindowBuilder::new()
                        .with_title("My App")
                        .with_inner_size(LogicalSize::new(800, 600))
                )
                .with_disable_context_menu(true)  // No right-click menu
                .with_background_color((255, 255, 255, 255))  // RGBA
                .with_devtools(cfg!(debug_assertions))  // DevTools in debug
        )
        .launch(App);
}
```

### with_on_window_ready (0.7.1+)

Run callback before webview is created. Essential for WGPU overlays and z-ordering:

```rust
dioxus::LaunchBuilder::new()
    .with_cfg(
        dioxus::desktop::Config::new()
            .with_on_window_ready(|window| {
                // Configure window before webview attaches
                // Useful for child windows, z-ordering textures
            })
    )
    .launch(App);
```

## Dioxus Native / Blitz (0.7+)

WGPU-based HTML/CSS renderer (no webview):

```bash
dx serve --platform native
```

Uses Taffy (flexbox), Stylo (CSS), Vello (GPU rendering). Still maturing.

## Subsecond Hot-Patching (0.7+)

Edit Rust code and see changes without losing app state. Works automatically with `dx serve`. For non-Dioxus projects:

```rust
loop {
    subsecond::call(|| my_function());  // hot-patched on save
}
```

**Limitations** (requires full rebuild):
- Struct/enum field changes (size/alignment changes crash)
- Workspace library crates (only tip crate patches)
- iOS device builds (code signing prevents patching)

### RSX Hot-Reload Boundaries

RSX template changes are hot-reloaded separately from Rust code.

**Hot-reloadable** (instant):
- Literal values, text content
- Formatted segments `"{variable}"`
- Reordering attributes
- Template structure changes

**Requires rebuild**:
- Rust code changes (logic, expressions)
- Component structure changes
- Control flow condition changes (`if`/`for` expressions)

## Dioxus Primitives (0.7+)

First-party Radix-UI style components (28 accessible, unstyled primitives). See dioxuslabs.com/components.
