import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/core/constants/app_constants.dart';

import '../../../../config/multi_language/multi_language.dart';
import '../../../../config/router/router.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/custom_utils.dart';
import '../../../../injection_container.dart';
import '../../../splash/domain/usecases/get_user_local_data.dart';
import '../../domain/usecases/update_user_local_data.dart';
import 'theme_state.dart';

class ThemeNotifier extends Notifier<ThemeState> {
  final GetUserLocalData getUserLocalData;
  final UpdateUserLocalData updateUserLocalData;
  ThemeNotifier({
    required this.getUserLocalData,
    required this.updateUserLocalData,
  });

  @override
  ThemeState build() {
    _themeInit();
    return const ThemeState();
  }

  Future<void> _themeInit() async {
    final result = await getUserLocalData.call(NoParams());
    result.fold(
      (failure) {
        showCustomSnackBar(
          message:
              failure.message ?? "Unable to load user data from local storage.",
        );
      },
      (response) {
        final String themeName = response[themeKey] ?? "";
        final String languageCode = response[languageKey] ?? "";
        if (themeName.isNotEmpty) {
          final ThemeMode savedTheme = ThemeMode.values.firstWhere(
            (e) => e.toString() == themeName,
          );
          state = state.copywith(theme: savedTheme);
        }
        if (languageCode.isNotEmpty) {
          final Locale savedLocale = Locale(languageCode);
          setLocale(savedLocale);
        }
      },
    );
  }

  void setTheme(ThemeMode mode) {
    state = state.copywith(theme: mode);
  }

  void setLocale(Locale locale) {
    state = state.copywith(locale: locale);
    ref.read(localeProvider.notifier).state = locale;
  }

  Future<void> onContinueTap(bool isFromHomePage) async {
    state = state.copywith(status: ApiStatus.loading);
    final Map<String, dynamic> userData = {themeKey: state.theme.toString()};
    final localResult = await updateUserLocalData.call(
      UpdateUserParams(userData: userData),
    );
    localResult.fold(
      (failure) {
        showCustomSnackBar(
          message:
              failure.message ?? "Failed to save theme changes. Please retry.",
        );
        state = state.copywith(status: ApiStatus.error);
      },
      (_) {
        state = state.copywith(status: ApiStatus.success);
        isFromHomePage ? Head.back() : Head.offAll(AppPages.language);
      },
    );
  }

  Future<void> onLanguageContinueTap(bool isFromHomePage) async {
    state = state.copywith(status: ApiStatus.loading);
    final Map<String, dynamic> userData = {
      languageKey: state.locale.languageCode,
    };
    final localResult = await updateUserLocalData.call(
      UpdateUserParams(userData: userData),
    );
    localResult.fold(
      (failure) {
        showCustomSnackBar(
          message:
              failure.message ??
              "Failed to save language changes. Please retry.",
        );
        state = state.copywith(status: ApiStatus.error);
      },
      (_) {
        state = state.copywith(status: ApiStatus.success);
        isFromHomePage ? Head.back() : Head.offAll(AppPages.login);
      },
    );
  }
}

final themesProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  () => sl<ThemeNotifier>(),
);
