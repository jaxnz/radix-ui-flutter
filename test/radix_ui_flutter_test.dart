import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radix_ui_flutter/radix_ui_flutter.dart';

void main() {
  testWidgets('RadixButton renders and taps', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      RadixApp(
        theme: RadixThemeData(brightness: Brightness.light),
        home: Scaffold(
          body: Center(
            child: RadixButton(child: const Text('Press me'), onPressed: () => tapped = true),
          ),
        ),
      ),
    );

    expect(find.text('Press me'), findsOneWidget);
    await tester.tap(find.text('Press me'));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });
}
