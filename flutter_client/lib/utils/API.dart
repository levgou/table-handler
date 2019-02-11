import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

const baseUrl = "https://my-json-server.typicode.com";

Future getTable(String tableId) {
  var url = baseUrl + "/levgou/table-handler/tables/" + tableId;
  return http.get(url);
}

IOWebSocketChannel getTableChannel(String tableId) {
  return IOWebSocketChannel.connect('ws://echo.websocket.org/');
}
