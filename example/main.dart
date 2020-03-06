import 'package:flutter/material.dart';
import 'package:flipping_card/flipping_card.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flipping Card example',
      home: Cards('Flipping Card example'),
    );
  }
}

class Cards extends StatefulWidget {
  Cards(this.title);

  final String title;

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  CardSide _card1Side = CardSide.FrontSide;
  CardSide _card2Side = CardSide.BackSide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: <Widget>[
            /// First card, with two sides and size set by containers,
            /// flips when tapped.
            FlippingCard(
              frontChild: Container(
                  width: 200,
                  height: 150,
                  color: Colors.white,
                  child: Center(child: Text("Front"))),
              backChild: Container(
                  width: 200,
                  height: 150,
                  color: Colors.blueGrey,
                  child: Center(child: Text("Back"))),
              side: _card1Side,
              onTap: (side) {
                setState(() {
                  _card1Side = (side == CardSide.FrontSide)
                      ? CardSide.BackSide
                      : CardSide.FrontSide;
                });
              },
            ),

            /// Second card, shows 2 pictures and back side by default.
            /// Flips when tapped.
            FlippingCard(
              frontChild:
                  Image.network('https://picsum.photos/id/230/200/300.jpg'),
              backChild:
                  Image.network('https://picsum.photos/id/870/200/300.jpg'),
              side: _card2Side,
              onTap: (side) {
                setState(() {
                  _card2Side = (side == CardSide.FrontSide)
                      ? CardSide.BackSide
                      : CardSide.FrontSide;
                });
              },
            )
          ])),
    );
  }
}
