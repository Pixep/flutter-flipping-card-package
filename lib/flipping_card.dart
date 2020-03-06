/// This library provides the [FlippingCard] widget, a two-sided card
/// that animates.
library flipping_card;

import 'dart:math';
import 'dart:core';

import 'package:flutter/material.dart';

/// The side of a card.
enum CardSide { FrontSide, BackSide }

/// Signature of the callback called when a card is tapped.
typedef CardTapCallback = void Function(CardSide side);

/// A widget that displays an animated card with a front and back.
///
/// The [FlippingCard] widget provides a way to show content on a card with
/// two sides, [CardSide.FrontSide] and [CardSide.BackSide]. When changing from
/// one side to another, the card shows a 'flip' animation.
///
/// {@tool sample}
/// The default constructor creates a [FlippingCard] widget, with the front and
/// back content from [frontImage] and [backImage] respectively.
///
/// ```dart
/// FlippingCard(
///       frontImage: Image.asset("front.jpg"),
///       backImage: frontImage: Image.asset("back.jpg"),
///       side: CardSide.FrontSide,
///       onTap => (side) { print("Card tapped!);
///       })
/// ```
/// {@end-tool}
class FlippingCard extends StatefulWidget {
  FlippingCard(
      {Key key,
      this.frontImage,
      this.backImage,
      this.radius = 12,
      this.side = CardSide.FrontSide,
      this.onTap})
      : super(key: key);
  final Image frontImage;
  final Image backImage;
  final double radius;
  final CardSide side;
  final CardTapCallback onTap;

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlippingCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  CardSide _currentSide;

  @override
  void initState() {
    super.initState();

    _currentSide = widget.side;
    _animationController = AnimationController(
        value: widget.side == CardSide.FrontSide ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 350),
        vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _currentSide = CardSide.BackSide;
        } else if (status == AnimationStatus.completed) {
          _currentSide = CardSide.FrontSide;
        }
      });
  }

  @override
  void didUpdateWidget(FlippingCard oldWidget) {
    if (widget.side != _currentSide) {
      _flip();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _flip() {
    if (_animationStatus == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  double _shadowFactor() => cos(_animationController.value * pi).abs();

  double _distanceFactor() => 1 - _shadowFactor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 230,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(
                  0, 0, 0, (-0.2 + 0.70 * _shadowFactor()).clamp(0.0, 1.0)),
              blurRadius: 5 + 15 * _distanceFactor(),
              spreadRadius: -3 - 30 * _distanceFactor(),
              offset: Offset(
                  3 + 15 * _distanceFactor(), 3 + 15 * _distanceFactor()))
        ],
      ),
      child: Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0007)
          ..rotateY(_animationController.value < 0.5
              ? pi * _animationController.value
              : pi + pi * _animationController.value),
        child: GestureDetector(
          onTap: () => widget.onTap(_currentSide),
          child: _animationController.value <= 0.5
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(widget.radius),
                  child: widget.backImage)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(widget.radius),
                  child: widget.frontImage),
        ),
      ),
    );
  }
}
