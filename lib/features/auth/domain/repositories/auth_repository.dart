import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> login(
    String username,
    String password,
  );
}
