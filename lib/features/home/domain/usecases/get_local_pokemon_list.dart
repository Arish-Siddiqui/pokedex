import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/home_repository.dart';

class GetLocalPokemonList implements Usecase<List<Pokemon>, NoParams> {
  final HomeRepository repository;
  GetLocalPokemonList(this.repository);

  @override
  Future<Either<Failure, List<Pokemon>>> call(NoParams params) async {
    return repository.getLocalPokemonList();
  }
}
