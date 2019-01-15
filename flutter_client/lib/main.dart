import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/homepage.dart';
import 'package:rest_in_peace/screens/ordered_items.dart';
import 'package:rest_in_peace/utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isInDebugMode) {
      debugPrint("debug mode is on");
    }
    return MaterialApp(
      title: 'Rest In Pieces',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[600],
        accentColor: Colors.white,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
            subtitle: TextStyle(
                fontSize: 18.0, fontStyle: FontStyle.italic, height: 4.0),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            body2: TextStyle(fontSize: 11.0, fontFamily: 'Hind'),
            caption: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-1.5, -1.5),
                    color: Colors.red[600]),
                Shadow(
                    // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: Colors.red[600]),
                Shadow(
                    // topRight
                    offset: Offset(1.5, 1.5),
                    color: Colors.red[600]),
                Shadow(
                    // topLeft
                    offset: Offset(-1.5, 1.5),
                    color: Colors.red[600]),
              ],
            )),
      ),
      home: Scaffold(
        body: Center(child: OrderedItems("some-uuid")),
      ),
    );
  }
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
