import 'package:flutter/material.dart';

ThemeData restTheme = new ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
          subtitle: TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        )
);