import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://my-json-server.typicode.com";

class API {
  static Future getTable(String tableId) {
    var url = baseUrl + "/poseneror/rest/tables/" + tableId;
    return http.get(url);
  }
}