import '../../../../core/error/failure.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_data_source.dart';
import 'package:dartz/dartz.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> updateLocalUserData(
    Map<String, dynamic> userData,
  ) async {
    try {
      await localDataSource.updateUserData(userData);
      return Right(null);
    } catch (e) {
      return Left(CacheFailure('Local update failed: $e'));
    }
  }
}
