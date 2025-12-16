import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/crypto/presentation/pages/crypto_page.dart';
import '../../features/home/domain/entities/pokemon.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/pokemon_detail_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../core/presentation/widgets/widgets.dart';
import '../../features/theme/presentation/pages/language_page.dart';
import '../../features/theme/presentation/pages/theme_page.dart';
import 'app_navigation.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      AppPages.splash => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const SplashPage(),
      ),
      AppPages.login => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const LoginPage(),
      ),
      AppPages.theme => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          final ThemePageArguments? arguments =
              settings.arguments as ThemePageArguments?;
          return ThemePage(isFromHomePage: arguments?.isFromHomePage ?? false);
        },
      ),
      AppPages.language => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          final ThemePageArguments? arguments =
              settings.arguments as ThemePageArguments?;
          return LanguagePage(
            isFromHomePage: arguments?.isFromHomePage ?? false,
          );
        },
      ),
      AppPages.pokeDetail => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          final pokemon = settings.arguments as Pokemon;
          return PokemonDetailPage(pokemon: pokemon);
        },
      ),
      AppPages.home => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const HomePage(),
      ),
      AppPages.crypto => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const CryptoPage(),
      ),
      _ => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const CustomNoPageWidget(),
      ),
    };
  }
}

class ThemePageArguments {
  final bool isFromHomePage;
  const ThemePageArguments({this.isFromHomePage = false});
}
