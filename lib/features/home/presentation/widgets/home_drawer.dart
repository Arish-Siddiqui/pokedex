import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../config/multi_language/multi_language.dart';
import '../../../../config/router/router.dart';
import '../../../../core/constants/app_colors.dart';
import '../provider/home_provider.dart';

class HomeDrawer extends HookConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final loc = ref.watch(localizationProvider);

    final List<Map<String, dynamic>> services = [
      {
        "name": loc.translate(TranslationConst.changeTheme),
        "pageName": AppPages.theme,
        "argument": ThemePageArguments(isFromHomePage: true),
      },
      {
        "name": loc.translate(TranslationConst.changeLanguage),
        "pageName": AppPages.language,
        "argument": ThemePageArguments(isFromHomePage: true),
      },
      {
        "name": loc.translate(TranslationConst.encryptionDecryption),
        "pageName": AppPages.crypto,
      },
    ];

    final notifier = ref.read(homeProvider.notifier);
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      loc.translate(TranslationConst.pokedex),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Head.back(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Head.back();
                      Head.to(
                        services[index]["pageName"],
                        arguments: services[index]["argument"],
                      );
                    },
                    title: Text(
                      services[index]["name"],
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              ListTile(
                onTap: notifier.logOut,
                title: Row(
                  spacing: 8.0,
                  children: [
                    Icon(Icons.logout_rounded, color: AppColors.red),
                    Expanded(
                      child: Text(
                        loc.translate(TranslationConst.logOut),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
