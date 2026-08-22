# Agent instructions

## Product boundary

`act-flutter` is an independent first-class mobile and desktop product. It is
not a thin launcher for `act-desktop-app.rs`, and the Rust desktop application
is not a prerequisite for Flutter features.

Both products may consume the same versioned HTTP schemas and, later, a small
independently versioned Rust media core. UI implementation, release cadence,
and platform-specific capabilities remain independent.

## Engineering rules

- Keep layouts adaptive for phones, tablets, and desktop windows.
- Keep secrets and long-lived provider tokens server-side.
- Never include access tokens in URLs, logs, screenshots, fixtures, or source.
- Do not add WebViews for core studio functionality.
- Provider mutations must be explicit, authenticated, and idempotent.
- Prefer platform media APIs or a typed Rust FFI bridge for high-throughput
  media; do not move frame data over JSON or method channels.

## Quality gates

Run `dart format --output=none --set-exit-if-changed .`, `flutter analyze`, and
`flutter test` before publishing changes. Desktop CI must also build the Linux
runner from the same application source.

Do not rewrite unrelated user changes or use destructive Git commands.
