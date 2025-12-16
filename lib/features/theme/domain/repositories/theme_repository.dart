import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class ThemeRepository {
  Future<Either<Failure, void>> updateLocalUserData(
    Map<String, dynamic> userData,
  );
}
