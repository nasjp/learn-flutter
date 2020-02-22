#!/usr/bin/env bash
set -e

brew tap dart-lang/dart
brew install dart

cd /usr/local/bin
git clone https://github.com/flutter/flutter.git -b stable
/usr/local/bin/flutter/bin/flutter
