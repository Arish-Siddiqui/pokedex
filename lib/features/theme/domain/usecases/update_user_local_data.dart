import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/theme_repository.dart';

class UpdateUserLocalData implements Usecase<void, UpdateUserParams> {
  final ThemeRepository repository;
  UpdateUserLocalData(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    return await repository.updateLocalUserData(params.userData);
  }
}

class UpdateUserParams extends Equatable {
  final Map<String, dynamic> userData;
  const UpdateUserParams({required this.userData});

  @override
  List<Object?> get props => [userData];
}
