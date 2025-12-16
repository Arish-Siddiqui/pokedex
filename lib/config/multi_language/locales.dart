import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Supported locales
final supportedLocales = [
  const Locale('en'), // English
  const Locale('hi'), // Hindi
  const Locale('ta'), // Tamil
];

/// Riverpod state provider for current locale
final localeProvider = StateProvider<Locale>((ref) => supportedLocales.first);
