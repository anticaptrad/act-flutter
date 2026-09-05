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

## Repository-local Git worktrees

- Create or use a Git worktree only when the human operator explicitly authorizes it for the current task. Concurrency or a dirty checkout is not permission by itself.
- Put every authorized worktree at `<repository-root>/tmp/worktrees/<name>`; from the repository root, use `./tmp/worktrees/<name>`. Never place worktrees beside repositories or organization directories.
- Keep `tmp`, `temp`, `tmp/worktrees`, and `temp/worktrees` ignored in the repository-root `.gitignore`. Do not commit files from those directories.
- Relocate or remove a worktree only when the operator explicitly requests it. Before removal, preserve and publish intended changes, verify its commit is represented on the target branch, and confirm there are no tracked, untracked, ignored-sensitive, or in-use files that must survive. Remove it with `git worktree remove <path>` without `--force`; never delete a worktree directory with `rm`.
