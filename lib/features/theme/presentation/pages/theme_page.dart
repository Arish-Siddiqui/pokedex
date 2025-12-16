import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/core/constants/app_constants.dart';

import '../../../../config/multi_language/multi_language.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../provider/theme_provider.dart';
import '../widgets/widgets.dart';

class ThemePage extends HookConsumerWidget {
  final bool isFromHomePage;
  const ThemePage({this.isFromHomePage = false, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: buildBody(context, ref));
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loc = ref.watch(localizationProvider);
    final notifier = ref.read(themesProvider.notifier);
    final state = ref.watch(themesProvider);
    final List<Map<String, dynamic>> themes = [
      {"name": loc.translate(TranslationConst.light), "theme": ThemeMode.light},
      {"name": loc.translate(TranslationConst.dark), "theme": ThemeMode.dark},
      {
        "name": loc.translate(TranslationConst.system),
        "theme": ThemeMode.system,
      },
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate(TranslationConst.appAppearance),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ThemeTile(
                onTap: () => notifier.setTheme(themes[index]["theme"]),
                selectedTheme: state.theme,
                themeData: themes[index],
              ),
              separatorBuilder: (_, _) => const SizedBox(height: 16.0),
              itemCount: themes.length,
            ),
            const Spacer(),
            CustomButton(
              disable: state.status == ApiStatus.loading,
              name: loc.translate(TranslationConst.continueKey),
              onTap: () => notifier.onContinueTap(isFromHomePage),
            ),
          ],
        ),
      ),
    );
  }
}
