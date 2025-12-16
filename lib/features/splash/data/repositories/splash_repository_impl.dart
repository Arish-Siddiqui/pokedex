import '../../../../core/error/failure.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_local_data_source.dart';
import 'package:dartz/dartz.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource localDataSource;

  SplashRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, Map<dynamic, dynamic>> fetchUserData() {
    try {
      final result = localDataSource.getUserData();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to fetch user local data: $e'));
    }
  }
}
