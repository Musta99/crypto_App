import 'dart:convert';

import 'package:http/http.dart';

var api_key = "C26EBCDF-4DD7-47F7-B979-F8C4CEAC2A27";

class Network {
  Future btctousdt(String currency) async {
    var response = await get(
      Uri.parse(
          "https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=$api_key"),
    );
    return jsonDecode(response.body);
  }
}
