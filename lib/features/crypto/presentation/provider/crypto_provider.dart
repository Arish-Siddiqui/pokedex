import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/util/custom_utils.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/encrypt_or_decrypt_data.dart';
import 'crypto_state.dart';

class CryptoProvider extends AutoDisposeNotifier<CryptoState> {
  final EncryptOrDecryptData encryptOrDecryptData;
  CryptoProvider({required this.encryptOrDecryptData});

  @override
  CryptoState build() {
    return const CryptoState();
  }

  void changeAlgorithm(CryptoAlgorithm? algorithm) {
    state = state.copywith(
      algorithm: algorithm,
      encryptedText: "",
      decryptedText: "",
    );
  }

  void encryptData(String text) async {
    final encryptedResult = await encryptOrDecryptData.call(
      EncryptOrDecryptParams(
        text: text,
        algorithm: state.algorithm,
        decrpytData: false,
      ),
    );
    encryptedResult.fold(
      (failure) {
        showCustomSnackBar(
          message: failure.message ?? "Failed to encrypt data",
        );
      },
      (response) {
        state = state.copywith(encryptedText: response);
      },
    );
  }

  void decryptData() async {
    final decryptedResult = await encryptOrDecryptData.call(
      EncryptOrDecryptParams(
        text: state.encryptedText,
        algorithm: state.algorithm,
        decrpytData: true,
      ),
    );
    decryptedResult.fold(
      (failure) {
        showCustomSnackBar(
          message: failure.message ?? "Failed to decrypt data",
        );
      },
      (response) {
        state = state.copywith(decryptedText: response);
      },
    );
  }
}

final cryptoProvider =
    NotifierProvider.autoDispose<CryptoProvider, CryptoState>(
      () => sl<CryptoProvider>(),
    );
