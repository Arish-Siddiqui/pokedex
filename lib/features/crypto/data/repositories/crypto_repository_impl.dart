import 'package:test_app/core/constants/app_constants.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/crypto_repository.dart';
import 'package:dartz/dartz.dart';

import '../service/crypto_service.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoService cryptoService;

  CryptoRepositoryImpl({required this.cryptoService});

  @override
  Either<Failure, String> decryptText({
    required String text,
    required CryptoAlgorithm algorithm,
  }) {
    try {
      final String result = algorithm == CryptoAlgorithm.rsa
          ? cryptoService.decryptRSA(text)
          : cryptoService.decryptAES(text);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to decrypt data: $e'));
    }
  }

  @override
  Either<Failure, String> encryptText({
    required String text,
    required CryptoAlgorithm algorithm,
  }) {
    try {
      final result = algorithm == CryptoAlgorithm.rsa
          ? cryptoService.encryptRSA(text)
          : cryptoService.encryptAES(text);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to encrypt data: $e'));
    }
  }
}
