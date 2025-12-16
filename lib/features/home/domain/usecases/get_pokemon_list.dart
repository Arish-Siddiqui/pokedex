import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/home_repository.dart';

class GetPokemonList implements Usecase<List<Pokemon>, GetPokemonListParams> {
  final HomeRepository repository;
  GetPokemonList(this.repository);

  @override
  Future<Either<Failure, List<Pokemon>>> call(
    GetPokemonListParams params,
  ) async {
    return await repository.getPokemonList(offset: params.offset);
  }
}

class GetPokemonListParams extends Equatable {
  final int offset;

  const GetPokemonListParams({required this.offset});

  @override
  List<Object?> get props => [offset];
}
