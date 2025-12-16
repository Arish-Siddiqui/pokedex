import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../config/multi_language/multi_language.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/util/custom_utils.dart';
import '../provider/auth_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginKey = useMemoized(() => GlobalKey<FormState>());

    final userNameController = useTextEditingController();
    final passwordController = useTextEditingController();

    final notifier = ref.read(authProvider.notifier);
    final state = ref.watch(authProvider);

    final theme = Theme.of(context);
    final loc = ref.watch(localizationProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: pendingScreenHeight!),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoWidget(size: screenHeight! * 0.1),
                const SizedBox(height: 48.0),
                Text(
                  loc.translate(TranslationConst.welcomeBack),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  loc.translate(TranslationConst.welcomeBackDescription),
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                ),
                const SizedBox(height: 48.0),
                CustomTextField(
                  controller: userNameController,
                  label: loc.translate(TranslationConst.username),
                  hint: loc.translate(TranslationConst.enterUserName),
                  validator: InputValidators.validateUserName,
                ),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: passwordController,
                  isPasswordField: true,
                  label: loc.translate(TranslationConst.password),
                  validator: InputValidators.validatePassword,
                ),
                const SizedBox(height: 48.0),
                CustomButton(
                  disable: state.status == ApiStatus.loading,
                  name: loc.translate(TranslationConst.login),
                  onTap: () {
                    if (loginKey.currentState!.validate()) {
                      notifier.logIn(
                        username: userNameController.text,
                        password: passwordController.text,
                      );
                    }
                    return;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
