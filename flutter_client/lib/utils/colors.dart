import 'package:flutter/material.dart';

class PieceColors {
  PieceColors._();

  static const Color backDrop = Color(0x80000000);

  static const Color transperentTeal = Color(0x8000CCBB);

  static const Color white = Color(0xFFF0FFFD);

  static const Color black = Color(0xFF003223);

  /// {@tool sample}
  ///
  /// ```dart
  /// Icon(
  ///   Icons.widgets,
  ///   color: PieceColors.teal[400],
  /// )
  /// ```
  /// {@end-tool}
  static const MaterialColor teal = MaterialColor(
    _tealPrimaryValue,
    <int, Color>{
      300: Color(0xFF00DACA),
      500: Color(_tealPrimaryValue),
      700: Color(0xFF00b2a3),
    },
  );
  static const int _tealPrimaryValue = 0xFF00CCBB;
}
