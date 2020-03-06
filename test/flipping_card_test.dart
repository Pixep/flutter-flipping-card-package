import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flipping_card/flipping_card.dart';

void main() {
  testWidgets('FlippingCard with no image', (WidgetTester tester) async {
    await tester.pumpWidget(FlippingCard());
  });

  testWidgets('FlippingCard front', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: FlippingCard(
            side: CardSide.FrontSide,
            frontChild: Text("frontText"),
            backChild: Text("backText"))));

    final frontFinder = find.text('frontText');
    final backFinder = find.text('backText');

    expect(frontFinder, findsOneWidget);
    expect(backFinder, findsNothing);
  });

  testWidgets('FlippingCard back', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: FlippingCard(
            side: CardSide.BackSide,
            frontChild: Text("frontText"),
            backChild: Text("backText"))));

    final frontFinder = find.text('frontText');
    final backFinder = find.text('backText');

    expect(frontFinder, findsNothing);
    expect(backFinder, findsOneWidget);
  });

  testWidgets('FlippingCard show back and front', (WidgetTester tester) async {
    await tester.pumpWidget(FlippingCard(side: CardSide.FrontSide));
    await tester.pumpWidget(FlippingCard(side: CardSide.BackSide));
  });

  testWidgets('FlippingCard with no image', (WidgetTester tester) async {
    await tester
        .pumpWidget(FlippingCard(onTap: (side) => print("Card tapped.")));
  });

  testWidgets('FlippingCard with different radius',
      (WidgetTester tester) async {
    await tester.pumpWidget(FlippingCard(radius: 0));
    await tester.pumpWidget(FlippingCard(radius: 5));
    await tester.pumpWidget(FlippingCard(radius: 50));
  });
}
