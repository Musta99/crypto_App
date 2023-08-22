import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/CurrencyList.dart';
import 'package:weather_app/dropdown.dart';
import 'package:weather_app/network.dart';
import 'dart:io';

void main() {
  runApp(CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0XFF21252B),
        ),
        home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String currency = "USD";
  late String rate = '';
  late String base = '';
  late String quote = '';

  List<Widget> cupertinoPicker() {
    List<Widget> pickerItems = [];

    for (String i in currencyList) {
      pickerItems.add(Text(i));
    }
    return pickerItems;
  }

  Widget androidDropDown() {
    List<DropdownMenuItem> dropdownItems = [];

    for (String i in currencyList) {
      dropdownItems.add(DropdownMenuItem(
        value: i,
        child: Text(i),
      ));
    }
    return DropdownButton<dynamic>(
      value: currency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          currency = value;
          getValue();
        });
      },
    );
  }

  Widget iosPicker() {
    return CupertinoPicker(
      children: cupertinoPicker(),
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        setState(() {
          currency = currencyList[index];
          getValue();
        });
        print(currency);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    getValue();
  }

  Future getValue() async {
    Network network = Network();
    var value = await network.btctousdt("$currency");
    print(value);

    var crate = value['rate'];
    var assetbase = value['asset_id_base'];
    var assetquote = value['asset_id_quote'];

    setState(() {
      rate = crate.toStringAsFixed(2);
      base = assetbase;
      quote = assetquote;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: Color(0xff282c33),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage("Images/bitcoin.png"),
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 30),
                        Text(
                          "$base/$quote",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [Text("$rate")],
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xff282c33),
              height: 200,
              width: double.infinity,
              child: Center(
                child: androidDropDown(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
