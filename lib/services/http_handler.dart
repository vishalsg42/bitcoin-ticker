import 'dart:convert';

import 'package:http/http.dart' as http;

const API_KEY = '44631E18-59EA-4313-AA65-2BFB3F7BD39C';

class HttpHandler {
  final String baseUrl;

  HttpHandler({this.baseUrl});

  Future<dynamic> get(String url) async {
    try {
      url = baseUrl + url + '?apiKey=$API_KEY';
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print('error $e');
    }
  }
}
