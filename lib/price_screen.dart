import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var emojiParser = EmojiParser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('${emojiParser.get('money_mouth_face').code} Coin Ticker'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28.0),
                  child: Text(
                    '1 BTC =? USD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                color: Colors.lightBlueAccent,
              ),
            ),
            Container(
              height: 150.0,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlueAccent,
              child: null,
            )
          ],
        ),
      ),
    );
  }
}
