import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform ;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String SelectedCurrency = 'INR';
  bool isWaiting = false;
  String value1 = '?';
  DropdownButton<String> android(){
    List<DropdownMenuItem<String>> dropItem = [];
    for(String currency in currenciesList){
        var newItem = DropdownMenuItem(
          child: Text(currency),
          value: currency,
        );
        dropItem.add(newItem);
    }

    return DropdownButton<String>(
        value: SelectedCurrency,
        items: dropItem ,
        onChanged: (value) {
          setState(()  {
              SelectedCurrency = value!;
              getData();
          });
        },
    );
  }

  CupertinoPicker ios(){
    List<Text> pickerlist = [];
    for(String currency in currenciesList){
      pickerlist.add(Text(currency));
    }

    return CupertinoPicker(
        itemExtent:32.0 ,
        onSelectedItemChanged: (Index){
          print(Index);
        },
        children: pickerlist,
    );
  }



  getData() async{
    try {
      double data =  await CoinData().getCoinData(SelectedCurrency);
      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(()  {
        value1 = data.toStringAsFixed(0);
      });
    }
    catch (e) {
      print(e);
    }
  }

  Text WidgetText(){
    return Text(
      '1 BTC = $value1 $SelectedCurrency',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: WidgetText(),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: WidgetText(),
          //     ),
          //
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.lightBlueAccent,
          //     elevation: 5.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: WidgetText(),
          //     ),
          //
          //   ),
          // ),
          // SizedBox(
          //   height: 240.0,
          // ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:Platform.isAndroid ? android() : ios(),
          ),
        ],
      ),
    );
  }
}
