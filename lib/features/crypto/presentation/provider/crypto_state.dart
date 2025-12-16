import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';

class CryptoState extends Equatable {
  final ApiStatus status;
  final CryptoAlgorithm algorithm;
  final String encryptedText;
  final String decryptedText;
  const CryptoState({
    this.status = ApiStatus.initial,
    this.algorithm = CryptoAlgorithm.aes,
    this.encryptedText = "",
    this.decryptedText = "",
  });

  CryptoState copywith({
    ApiStatus? status,
    CryptoAlgorithm? algorithm,
    String? encryptedText,
    String? decryptedText,
  }) {
    return CryptoState(
      status: status ?? this.status,
      algorithm: algorithm ?? this.algorithm,
      encryptedText: encryptedText ?? this.encryptedText,
      decryptedText: decryptedText ?? this.decryptedText,
    );
  }

  @override
  List<Object?> get props => [status, algorithm, encryptedText, decryptedText];
}
