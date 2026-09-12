import 'package:flutter/widgets.dart';
import 'package:shared_auth_flutter/shared_auth_flutter.dart';

import 'src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const SharedAuthAppShell(
      title: 'AntiCapTrad',
      child: AntiCapTradApp(),
    ),
  );
}
