import 'package:flutter/widgets.dart';
import 'package:ores_otel_flutter/ores_otel_flutter.dart';
import 'package:shared_auth_flutter/shared_auth_flutter.dart';

import 'src/app.dart';

void main() {
  final logger = Logger(appName: 'act_flutter');
  runOresFlutterApp(
    appName: 'act_flutter',
    emitToDeveloperLog: false,
    sinks: [NextLoggersStartupDiagnosticSink(logger: logger)],
    builder: (_) => const SharedAuthAppShell(
      title: 'AntiCapTrad',
      child: AntiCapTradApp(),
    ),
  );
}
