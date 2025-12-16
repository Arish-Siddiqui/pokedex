import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon.dart';
import '../entities/pokemon_detail.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemonList({required int offset});
  Future<Either<Failure, PokemonDetail>> getPokemonDetail({
    required String url,
  });
  Either<Failure, List<Pokemon>> getLocalPokemonList();
  Future<Either<Failure, void>> storePokemonLocally({
    required List<Pokemon> pokemons,
  });
}
