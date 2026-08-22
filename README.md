# AntiCapTrad Flutter studio

`act-flutter` is the adaptive mobile and desktop application for AntiCapTrad. It
coexists with [`act-desktop-app.rs`](https://github.com/anticaptrad/act-desktop-app.rs)
as an independent first-class product: both applications can introduce useful
features without waiting on or wrapping the other.

The initial vertical slice is a responsive broadcast workspace with:

- phone navigation and a desktop navigation rail from the same application;
- program-monitor, destination, session, and transport surfaces;
- independent destination arming for YouTube, Twitch, Rumble, StreamYard, and X;
- explicit placeholders for server-authorized connection and go-live flows;
- widget tests at mobile and desktop viewport sizes.

No provider credential is stored in this repository or passed through the UI.

## Development

Install Flutter stable, then:

```sh
flutter pub get
flutter analyze
flutter test
```

Flutter's platform host projects are generated artifacts. Bootstrap Android,
iOS, Linux, macOS, and Windows runners without replacing the application source:

```sh
./tool/bootstrap_platforms.sh
flutter run -d macos
```

The same source can then run with `-d linux`, `-d windows`, an Android device,
or an iOS device on a compatible host. CI regenerates a clean Linux runner and
builds it to keep desktop support executable rather than aspirational.

## Relationship to the native Rust app

The products share contracts and capability goals, not UI code:

| Concern | `act-flutter` | `act-desktop-app.rs` |
| --- | --- | --- |
| Primary reach | Mobile plus desktop | Native desktop studio |
| UI | Flutter/Dart | Qt Quick/QML |
| Platform advances | Mobile workflows, adaptive collaboration, portable UX | Native capture, codecs, GPU surfaces, low-latency studio control |
| Shared boundary | Versioned AntiCapTrad HTTP/events contracts | Versioned AntiCapTrad HTTP/events contracts |
| Future Rust reuse | Typed `flutter_rust_bridge` API where justified | Typed CXX-Qt API |

A future Rust media library may serve both applications. It must be independently
versioned, keep media frames off JSON/method channels, and avoid coupling either
product's release cycle to the other.

See [`docs/DESKTOP_PARITY.md`](docs/DESKTOP_PARITY.md) for the complementary
feature policy.

Licensed under the MIT License.
