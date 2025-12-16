import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/custom_utils.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/get_user_local_data.dart';

class SplashNotifier extends Notifier<void> {
  final GetUserLocalData getUserLocalData;
  SplashNotifier({required this.getUserLocalData});

  @override
  void build() {
    // no initial state
  }

  void goToNextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    final loggedInOrNot = await getUserLocalData.call(NoParams());
    loggedInOrNot.fold(
      (failure) {
        showCustomSnackBar(
          message: failure.message ?? "Failed to check logged in status",
        );
      },
      (response) {
        final String themeData = response[themeKey] ?? "";
        final String languageData = response[languageKey] ?? "";
        final bool isLoggedIn = response[isLoggedInKey] ?? false;
        if (themeData.isEmpty) {
          return Head.offAll(AppPages.theme);
        } else if (languageData.isEmpty) {
          return Head.offAll(AppPages.language);
        } else if (!isLoggedIn) {
          return Head.offAll(AppPages.login);
        } else {
          return Head.offAll(AppPages.home);
        }
      },
    );
  }
}

final splashProvider = NotifierProvider<SplashNotifier, void>(
  () => sl<SplashNotifier>(),
);
