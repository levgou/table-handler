import 'package:flutter/material.dart';
import 'package:rest_in_peace/screens/homePage/homepage.dart';
import 'package:rest_in_peace/utils/colors.dart';

void main() => runApp(MyApp());

var oldTheme = new ThemeData(
  brightness: Brightness.light,
  primaryColorLight: Colors.teal[300],
  highlightColor: Colors.teal[300],
  primaryColorDark: Colors.teal[700],
  accentColor: Colors.grey[50],
  backgroundColor: Colors.grey[50],
  primaryColor: Colors.teal[500],
  dialogBackgroundColor: Colors.teal[400],
  scaffoldBackgroundColor: Colors.grey[50],
  fontFamily: 'Montserrat',
  indicatorColor: Colors.teal[500],
  accentTextTheme: TextTheme(
    body1: TextStyle(
      fontSize: 14.0,
      fontFamily: 'Hind',
      color: Colors.teal[700],
    ),
  ),
  textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(
          fontSize: 28.0, fontStyle: FontStyle.italic, color: Colors.grey[50]),
      subtitle: TextStyle(
          fontSize: 18.0, fontStyle: FontStyle.italic, color: Colors.grey[50]),
      body1: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Hind',
      ),
      body2: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Hind',
        color: Colors.grey[50],
      ),
      display1: TextStyle(
        fontSize: 11.0,
        fontFamily: 'Hind',
      ),
      display2: TextStyle(
        fontSize: 11.0,
        fontFamily: 'Hind',
        color: Colors.grey[50],
      ),
      caption: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        shadows: [
          Shadow(
              // bottomLeft
              offset: Offset(-1, -1),
              color: Colors.teal[300]),
          Shadow(
              // bottomRight
              offset: Offset(1, -1),
              color: Colors.teal[300]),
          Shadow(
              // topRight
              offset: Offset(1, 1),
              color: Colors.teal[300]),
          Shadow(
              // topLeft
              offset: Offset(-1, 1),
              color: Colors.teal[300]),
        ],
      )),
);

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
        body: Center(child: HomePage()),
      ),
    );
  }
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
