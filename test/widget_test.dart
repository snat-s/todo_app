import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/main.dart';
import 'package:todo_app/new_todo.dart'; // package import or local import?

void main() {
  group('Check the main components in the app', () {
    testWidgets('Check if the app launches', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());
      expect(find.text('Wow such empty'), findsOneWidget);
      //expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('Check if you can introduce text and then delete it',
        ((WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: NewTodo()));
      await tester.enterText(find.byType(TextField), 'Hello World!');
      await tester.tap(find.byType(Icon));
      await tester.pump();
      expect(find.text('Hello World!'), findsNothing);
      await tester.enterText(find.byType(TextField), 'Hello World!');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      expect(find.text('Hello World!'), findsNothing);
    }));
    testWidgets('Test the entire app', ((tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Hello World!');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      await tester.tap(find.byType(BackButtonIcon));
      await tester.pumpAndSettle();
      expect(find.text('Hello World!'), findsWidgets);
      await tester.drag(find.byType(PageView), const Offset(-800.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.text('TODO'), findsOneWidget);
      expect(find.text('Hello World!'), findsOneWidget);
      await tester.drag(find.byType(PageView), const Offset(-800.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.text('DONE'), findsOneWidget);
      expect(find.text('Hello World!'), findsNothing);
      expect(find.text('Wow such empty'), findsOneWidget);
      await tester.drag(find.byType(PageView), const Offset(1600.0, 0.0));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.check));
      await tester.pump();
      await tester.drag(find.byType(PageView), const Offset(-1600.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.text('Hello World!'), findsOneWidget);
      await tester.drag(find.byType(PageView), const Offset(800.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.text('Hello World!'), findsNothing);
    }));
  });
}
