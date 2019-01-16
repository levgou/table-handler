import 'dart:convert';
import 'package:rest_in_peace/models/TableSession.dart';
import 'package:rest_in_peace/utils/API.dart';

Future<TableSession> getTable(String tableId) async {
  var response = await API.getTable(tableId);
  return TableSession.fromJson(json.decode(response.body));
}
