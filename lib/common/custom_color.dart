import 'package:flutter/material.dart';

class CustomColor {
  static const _blackMonoValue = 0xFF666666;

  static const MaterialColor black =
      MaterialColor(_blackMonoValue, <int, Color>{
    0: Color(_blackMonoValue),
    2: Color(0xFF999999),
    1: Color(0xFFCCCCCC),
    3: Color(0xFFE5E5E5),
  });

  static const _yellowPrimaryValue = 0xFFFFCC1F;
  static const MaterialColor yellow = MaterialColor(
      _yellowPrimaryValue, <int, Color>{0: Color(_yellowPrimaryValue)});

  static const _redSemantic = 0xFFCE0200;
  static const MaterialColor pink =
      MaterialColor(_redSemantic, <int, Color>{0: Color(_redSemantic)});

  static const _greenSemantic = 0xFF00993C;
  static const MaterialColor green =
      MaterialColor(_greenSemantic, <int, Color>{0: Color(_greenSemantic)});

  static const _white = 0xFFFFFFFFF;
  static const MaterialColor white =
      MaterialColor(_white, <int, Color>{0: Color(_white)});

  static const _gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFFF4F), Color(0xFFFFa74F)]);

  static LinearGradient get gradientColor {
    return _gradient;
  }
}
