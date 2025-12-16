import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LogInUser implements Usecase<Map<String, dynamic>, LoginUserParams> {
  final AuthRepository repository;
  LogInUser(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    LoginUserParams params,
  ) async {
    return await repository.login(params.username, params.password);
  }
}

class LoginUserParams extends Equatable {
  final String username;
  final String password;
  const LoginUserParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
