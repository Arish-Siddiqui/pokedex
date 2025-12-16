import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/multi_language/multi_language.dart';
import '../../../features/theme/presentation/provider/theme_provider.dart';
import '../../constants/app_colors.dart';
import 'app_themes.dart';

class InitializationErrorApp extends HookConsumerWidget {
  const InitializationErrorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themesProvider);
    final locale = ref.watch(localeProvider);
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeState.theme,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        body: Center(
          child: Text(
            'Something went wrong while starting the app.\nPlease restart.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.red, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
