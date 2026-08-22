# Complementary product policy

## Principle

Flutter desktop and the native Rust desktop studio are peers. Parity means that
users can complete core AntiCapTrad workflows in either product; it does not
mean that every implementation, screen, or platform specialization must match.

## Shared capability floor

Both desktop products should eventually support:

- authenticated AntiCapTrad sessions without locally persisted provider keys;
- provider connection status and capability discovery;
- video library browsing, upload status, metadata, and scheduling;
- idempotent start/stop stream orchestration;
- health, degradation, retry, and audit visibility;
- YouTube, Twitch, Rumble, StreamYard, and X publication workflows where each
  provider exposes the necessary supported API.

These flows are governed by versioned schemas in `act-interfaces`, not by one
desktop application's internal model.

## Independent innovation lanes

Flutter should push mobile/desktop continuity, touch-first production,
collaboration, notification workflows, and a consistent adaptive experience.

The native Rust application should push native capture, hardware codec and GPU
integration, bounded media pipelines, UDP/WebRTC diagnostics, and demanding
multi-source studio workflows.

Useful innovations may cross over through a documented contract. Neither team
waits for mirrored UI before shipping a safe, tested platform improvement.

## Shared Rust code threshold

Introduce a shared Rust crate only when all of these are true:

1. the media or protocol boundary has stabilized in at least one product;
2. the crate is useful without importing Qt or Flutter UI concepts;
3. its operations are cancellable and queues have explicit capacities;
4. CXX-Qt and `flutter_rust_bridge` can expose small typed control APIs;
5. raw frames remain on native/shared memory or GPU paths;
6. the crate has independent semantic versions and conformance tests.
