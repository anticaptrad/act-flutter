#!/usr/bin/env sh

set -eu

# Flutter owns these platform runners. Application code remains in lib/ and is
# intentionally independent from generated Xcode, Visual Studio, CMake, and
# mobile host projects.
flutter create \
  --org com.anticaptrad \
  --project-name act_flutter \
  --platforms android,ios,linux,macos,windows \
  .
