# flipping_card

A Flutter package that provides a two-sided animated FlippingCard widget.

The [FlippingCard] widget provides a way to show content on a card with two sides,
`CardSide.FrontSide` and `CardSide.BackSide`. When changing from one side to another,
the card shows a 'flip' animation.

```dart
FlippingCard(
    frontChild: Image.asset("front.jpg"),
    backChild: Image.asset("back.jpg"),
    side: CardSide.FrontSide,
    onTap => (side) { print("Card tapped!); })
```
