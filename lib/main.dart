import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'config/multi_language/multi_language.dart';
import 'config/router/router.dart';
import 'core/constants/app_constants.dart';
import 'core/network/network.dart';
import 'core/presentation/app/app_themes.dart';
import 'core/presentation/app/initialization_error_app.dart';
import 'core/presentation/widgets/widgets.dart';
import 'features/theme/presentation/provider/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'injection_container.dart' as di;

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(details: details);
  };

  WidgetsFlutterBinding.ensureInitialized();
  try {
    final dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);
    await di.init();
    runApp(const ProviderScope(child: MyApp()));
  } catch (e, _) {
    runApp(const ProviderScope(child: InitializationErrorApp()));
  }
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      verifyConnection();
      return null;
    }, []);

    final themeState = ref.watch(themesProvider);
    final locale = ref.watch(localeProvider);
    final mQ = MediaQuery.of(context);
    screenHeight = mQ.size.height;
    screenWidth = mQ.size.width;
    pendingScreenHeight =
        mQ.size.height - (mQ.viewPadding.top + mQ.viewPadding.bottom);
    return MaterialApp(
      title: 'Pokedex',
      scaffoldMessengerKey: messangerKey,
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
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
