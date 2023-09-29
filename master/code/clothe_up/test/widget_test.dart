import 'package:clothe_up/home_page.dart';
import 'package:clothe_up/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clothe_up/main.dart';

void main() {
  testWidgets('ClotheUp App Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ShoppingApp());

    // Verify that the home page is displayed initially.
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(LoginPage), findsNothing);

    // Tap the 'LOGIN' button and trigger a frame.
    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pump();

    // Verify that the login page is displayed after tapping the 'LOGIN' button.
    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(LoginPage), findsOneWidget);

    // Add more test cases as needed for the app's functionality.
  });
}
