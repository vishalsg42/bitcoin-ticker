import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_dart.dart';
import 'package:bitcoin_ticker/services/http_handler.dart';
import 'package:bitcoin_ticker/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var emojiParser = EmojiParser();
  String selectedCurrency;
  bool showLoader = true;

  List<Widget> currencyList = [];

  @override
  void initState() {
    super.initState();
    selectedCurrency = currenciesList[0];
    getCoinList();
  }

  Future<void> getCoinList() async {
    HttpHandler httpHandler = HttpHandler(baseUrl: 'https://rest.coinapi.io/');
    print('selectedCurrency $selectedCurrency');
    List<Widget> coinWidget = [];
    for (int index = 0; index < cryptoList.length; index++) {
      var coinData = await httpHandler
          .get('v1/exchangerate/${cryptoList[index]}/$selectedCurrency');
      var rate = coinData['rate'];
      coinWidget.add(Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28.0),
            child: Text(
              "1 ${cryptoList[index]} = ${rate.round().toString()} $selectedCurrency",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          color: Colors.lightBlueAccent,
        ),
      ));
    }
    setState(() {
      currencyList = coinWidget;
      showLoader = false;
    });
  }

  DropdownButton getAndroidPicker() {
    List<DropdownMenuItem<String>> currencyDropdown = [];
    for (int index = 0; index < currenciesList.length; index++) {
      String currency = currenciesList[index];
      currencyDropdown.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency ?? currenciesList[0] ?? 'USD',
      style: TextStyle(
        color: Colors.black,
      ),
      items: currencyDropdown,
      onChanged: (String value) {
        setState(() {
          selectedCurrency = value;
          getCoinList();
        });
      },
    );
  }

  CupertinoPicker getIOSPicker() {
    List<Text> currencyDropdown = [];
    for (int index = 0; index < currenciesList.length; index++) {
      String currency = currenciesList[index];
      currencyDropdown.add(
        Text(
          currency,
          textAlign: TextAlign.center,
        ),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      children: currencyDropdown,
      onSelectedItemChanged: (value) {
        print(value);
      },
      itemExtent: 32.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('${emojiParser.get('money_mouth_face').code} Coin Ticker'),
          centerTitle: true,
        ),
        body: showLoader
            ? spinkit
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: currencyList,
                  ),
                  Container(
                    height: 150.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: Colors.lightBlue,
                    child: Platform.isIOS ? getIOSPicker() : getAndroidPicker(),
                  )
                ],
              ),
      ),
    );
  }
}
