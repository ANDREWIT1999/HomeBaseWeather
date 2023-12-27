import 'package:flutter/material.dart';

extension NumberParsing on num {
  SizedBox get vertical => SizedBox(
        height: toDouble(),
      );
  SizedBox get horizontal => SizedBox(
        width: toDouble(),
      );

  /// Convert temperature to Celsius
  double? get celsius => this - 273.15;
}
extension StringParsing on String {
 bool isLocationValid () =>
 
   isNotEmpty;


}
