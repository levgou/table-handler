import 'dart:convert';
import 'package:rest_in_peace/models/RestTable.dart';
import 'package:rest_in_peace/utils/API.dart';

Future<RestTable> getTable(String tableId) async {
  var response = await API.getTable(tableId);
  return RestTable.fromJson(json.decode(response.body));
}
