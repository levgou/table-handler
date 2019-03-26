import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/homePage/homepage.dart';
import 'package:rest_in_peace/utils/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isInDebugMode) {
      debugPrint("debug mode is on");
    }
    return MaterialApp(
      title: 'YourPiece',
      theme: new ThemeData(
        primaryColor: PieceColors.teal[500],
        primaryColorDark: PieceColors.teal[700],
        primaryColorLight: PieceColors.teal[300],
        backgroundColor: PieceColors.white,
        accentColor: PieceColors.white,
        textTheme: TextTheme(
          body1: TextStyle(color: PieceColors.black, fontSize: 15.0),
          body2: TextStyle(color: PieceColors.black, fontSize: 13.0),
        ),
        accentTextTheme: TextTheme(
          title: TextStyle(color: PieceColors.white, fontSize: 25.0),
          subtitle: TextStyle(color: PieceColors.white, fontSize: 20.0),
          button: TextStyle(color: PieceColors.white, fontSize: 20.0),
          body1: TextStyle(color: PieceColors.white, fontSize: 15.0),
          body2: TextStyle(color: PieceColors.white, fontSize: 13.0),
          caption: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(-1, -1),
                color: PieceColors.teal[700],
              ),
              Shadow(
                offset: Offset(1, -1),
                color: PieceColors.teal[700],
              ),
              Shadow(
                offset: Offset(1, 1),
                color: PieceColors.teal[700],
              ),
              Shadow(
                offset: Offset(-1, 1),
                color: PieceColors.teal[700],
              ),
            ],
          ),
        ),
      ),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
