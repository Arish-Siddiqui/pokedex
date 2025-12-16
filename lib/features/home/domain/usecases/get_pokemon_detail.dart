import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_detail.dart';
import '../repositories/home_repository.dart';

class GetPokemonDetail
    implements Usecase<PokemonDetail, GetPokemonDetailParams> {
  final HomeRepository repository;
  GetPokemonDetail(this.repository);

  @override
  Future<Either<Failure, PokemonDetail>> call(
    GetPokemonDetailParams params,
  ) async {
    return await repository.getPokemonDetail(url: params.url);
  }
}

class GetPokemonDetailParams extends Equatable {
  final String url;

  const GetPokemonDetailParams({required this.url});

  @override
  List<Object?> get props => [url];
}
