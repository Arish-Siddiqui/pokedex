import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/crypto_repository.dart';

class EncryptOrDecryptData implements Usecase<String, EncryptOrDecryptParams> {
  final CryptoRepository repository;
  EncryptOrDecryptData(this.repository);

  @override
  Future<Either<Failure, String>> call(EncryptOrDecryptParams params) async {
    return Future.value(
      params.decrpytData
          ? repository.decryptText(
              text: params.text,
              algorithm: params.algorithm,
            )
          : repository.encryptText(
              text: params.text,
              algorithm: params.algorithm,
            ),
    );
  }
}

class EncryptOrDecryptParams extends Equatable {
  final String text;
  final CryptoAlgorithm algorithm;
  final bool decrpytData;
  const EncryptOrDecryptParams({
    required this.text,
    required this.algorithm,
    required this.decrpytData,
  });

  @override
  List<Object?> get props => [text, algorithm, decrpytData];
}
