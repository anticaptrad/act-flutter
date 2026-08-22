import 'package:act_flutter/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('mobile layout exposes studio destinations and navigation', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(430, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AntiCapTradApp());
    await tester.pumpAndSettle();

    expect(find.text('@anticaptrad'), findsOneWidget);
    expect(find.text('YouTube'), findsOneWidget);
    expect(find.text('Rumble'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('Schedule'));
    await tester.pumpAndSettle();
    expect(
      find.text('Schedule is the next independent product slice'),
      findsOneWidget,
    );
  });

  testWidgets('desktop layout uses a navigation rail', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AntiCapTradApp());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('PROGRAM MONITOR'), findsOneWidget);
    expect(find.text('X / Twitter'), findsOneWidget);
    expect(find.text('Flutter 3 · Dart 3'), findsOneWidget);
  });
}
