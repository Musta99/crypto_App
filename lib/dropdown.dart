import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    String currency = "AUD";

    return DropdownButton<dynamic>(
      value: currency,
      items: [
        DropdownMenuItem(
          value: "USD",
          child: Text("USD"),
        ),
        DropdownMenuItem(
          value: "CAD",
          child: Text("CAD"),
        ),
        DropdownMenuItem(
          value: "AUD",
          child: Text("AUD"),
        ),
      ],
      onChanged: (value) {
        setState(() {
          print("$currency");
        });
      },
    );
  }
}
