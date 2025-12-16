import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/util/custom_utils.dart';
import '../../../../injection_container.dart';
import '../../../theme/domain/usecases/update_user_local_data.dart';
import '../../domain/usecases/log_in_user.dart';
import 'auth_state.dart';

class AuthStateNotifier extends Notifier<AuthState> {
  final LogInUser loginUser;
  final UpdateUserLocalData updateUserLocalData;
  AuthStateNotifier({
    required this.loginUser,
    required this.updateUserLocalData,
  });

  @override
  AuthState build() {
    return const AuthState();
  }

  void logIn({required String username, required String password}) async {
    state = state.copywith(status: ApiStatus.loading);
    final result = await loginUser.call(
      LoginUserParams(username: username, password: password),
    );
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(message: failure.message ?? "Failed to log in");
      },
      (response) {
        state = state.copywith(status: ApiStatus.success);
        _saveUserDataLocally(response);
        Head.offAll(AppPages.home);
      },
    );
  }

  Future<void> _saveUserDataLocally(Map<String, dynamic> userData) async {
    userData.addAll({isLoggedInKey: true});
    final localResult = await updateUserLocalData.call(
      UpdateUserParams(userData: userData),
    );
    localResult.fold((failure) {
      showCustomSnackBar(
        message: failure.message ?? "Failed to save user data. Please retry.",
      );
    }, (_) {});
  }
}

final authProvider = NotifierProvider<AuthStateNotifier, AuthState>(
  () => sl<AuthStateNotifier>(),
);
