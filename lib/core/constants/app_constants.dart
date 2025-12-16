// Declare variables that can globally used through out the App.

import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> messangerKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

enum ApiStatus { initial, loading, success, error }

enum CryptoAlgorithm { aes, rsa }

const String connectionTimeOutMessage =
    'Connection timed out. Please try again.';
const String unexpectedErrorMessage =
    'An unexpected error occurred. Please try again.';

double? screenHeight;
double? pendingScreenHeight;
double? screenWidth;
String? userUID;

// Keys used for shared prefs
const String userDataKey = "userData";
const String themeKey = "theme";
const String languageKey = "language";
const String isLoggedInKey = "isLoggedIn";
const String tasksKey = "tasksKey";
// Local DB names
const String userBox = "userBox";
const String pokemonBox = "pokemonBox";
