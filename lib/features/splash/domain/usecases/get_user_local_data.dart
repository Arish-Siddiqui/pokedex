import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/splash_repository.dart';

class GetUserLocalData implements Usecase<Map<dynamic, dynamic>, NoParams> {
  final SplashRepository repository;
  GetUserLocalData(this.repository);

  @override
  Future<Either<Failure, Map<dynamic, dynamic>>> call(NoParams noParams) async {
    return Future.value(repository.fetchUserData());
  }
}
