import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failure.dart';

abstract class CryptoRepository {
  Either<Failure, String> encryptText({
    required String text,
    required CryptoAlgorithm algorithm,
  });
  Either<Failure, String> decryptText({
    required String text,
    required CryptoAlgorithm algorithm,
  });
}
