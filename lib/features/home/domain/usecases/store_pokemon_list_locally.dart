import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/home_repository.dart';

class StorePokemonListLocally
    implements Usecase<void, StorePokemonListLocallyParams> {
  final HomeRepository repository;
  StorePokemonListLocally(this.repository);

  @override
  Future<Either<Failure, void>> call(
    StorePokemonListLocallyParams params,
  ) async {
    return await repository.storePokemonLocally(pokemons: params.pokemons);
  }
}

class StorePokemonListLocallyParams extends Equatable {
  final List<Pokemon> pokemons;

  const StorePokemonListLocallyParams({required this.pokemons});

  @override
  List<Object?> get props => [pokemons];
}
