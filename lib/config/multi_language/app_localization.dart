import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'locales.dart';
import 'translations/english_translation.dart';
import 'translations/hindi_translation.dart';
import 'translations/tamil_translation.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static Map<String, Map<String, String>> localizedValues = {
    'en': englishTranslation,
    'hi': hindiTranslation,
    'ta': tamilTranslation,
  };

  String translate(String key) {
    return localizedValues[locale.languageCode]?[key] ??
        localizedValues['en']![key]!;
  }
}

final localizationProvider = Provider<AppLocalizations>((ref) {
  final locale = ref.watch(localeProvider);
  return AppLocalizations(locale);
});
