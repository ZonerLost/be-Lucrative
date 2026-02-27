import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  /// ==============================
  ///  Heading Large (24px SemiBold)
  /// ==============================
  static const TextStyle heading24SemiBold = TextStyle(
    fontFamily: 'InterTight',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2, // 120% line-height
    letterSpacing: 0,
  );


  static const TextStyle body14Regular = TextStyle(
    fontFamily: 'InterTight',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.0, // 100% line-height
    letterSpacing: 0,
  );


  static const TextStyle button16SemiBold = TextStyle(
    fontFamily: 'InterTight',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2, // 120% line-height
    letterSpacing: 0,
  );
}