import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/core/constants/app_constants.dart';

import '../../../../config/multi_language/multi_language.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../provider/theme_provider.dart';
import '../widgets/widgets.dart';

class LanguagePage extends HookConsumerWidget {
  final bool isFromHomePage;
  const LanguagePage({this.isFromHomePage = false, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: buildBody(context, ref));
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loc = ref.watch(localizationProvider);
    final notifier = ref.read(themesProvider.notifier);
    final state = ref.watch(themesProvider);

    final availableLanguages = <Map<String, dynamic>>[
      {"name": "English", "locale": const Locale('en')},
      {"name": "हिन्दी", "locale": const Locale('hi')}, // Hindi
      {"name": "தமிழ்", "locale": const Locale('ta')}, // Tamil
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate(TranslationConst.chooseLan),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => LanguageTile(
                onTap: () {
                  notifier.setLocale(
                    availableLanguages[index]["locale"] as Locale,
                  );
                },
                selectedLanguage: state.locale,
                languageData: availableLanguages[index],
              ),
              separatorBuilder: (_, _) => const SizedBox(height: 16.0),
              itemCount: availableLanguages.length,
            ),
            const Spacer(),
            CustomButton(
              disable: state.status == ApiStatus.loading,
              name: loc.translate(TranslationConst.continueKey),
              onTap: () => notifier.onLanguageContinueTap(isFromHomePage),
            ),
          ],
        ),
      ),
    );
  }
}
