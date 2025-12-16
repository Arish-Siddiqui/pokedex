import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../config/multi_language/multi_language.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/util/custom_utils.dart';
import '../provider/crypto_provider.dart';

class CryptoPage extends HookConsumerWidget {
  const CryptoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loc = ref.watch(localizationProvider);

    final textController = useTextEditingController();

    final notifier = ref.read(cryptoProvider.notifier);
    final state = ref.watch(cryptoProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          loc.translate(TranslationConst.encryptionDecryption),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: textController,
              label: loc.translate(TranslationConst.data),
              hint: loc.translate(TranslationConst.enterYourData),
              minLines: 3,
              maxLines: 3,
              validator: InputValidators.validateUserInput,
            ),
            RadioGroup<CryptoAlgorithm>(
              onChanged: notifier.changeAlgorithm,
              groupValue: state.algorithm,
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile<CryptoAlgorithm>(
                      title: Text(loc.translate(TranslationConst.aes)),
                      value: CryptoAlgorithm.aes,
                      contentPadding: EdgeInsets.zero,
                      activeColor: theme.colorScheme.tertiary,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<CryptoAlgorithm>(
                      title: Text(loc.translate(TranslationConst.rsa)),
                      value: CryptoAlgorithm.rsa,
                      contentPadding: EdgeInsets.zero,
                      activeColor: theme.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              name: loc.translate(TranslationConst.encrypt),
              onTap: () => notifier.encryptData(textController.text),
            ),
            const SizedBox(height: 16.0),
            Text(
              loc.translate(TranslationConst.encryptedText),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              state.encryptedText,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),
            CustomButton(
              name: loc.translate(TranslationConst.decrypt),
              onTap: notifier.decryptData,
            ),
            const SizedBox(height: 16.0),
            Text(
              loc.translate(TranslationConst.decryptedText),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              state.decryptedText,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
