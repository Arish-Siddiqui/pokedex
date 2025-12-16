import 'package:equatable/equatable.dart';
import 'package:test_app/features/home/domain/entities/pokemon_detail.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/pokemon.dart';

class HomeState extends Equatable {
  final ApiStatus status;
  final List<Pokemon> pokemons;
  final List<Pokemon> cachedPokemons;
  final PokemonDetail? pokemonDetail;
  final int offset;
  const HomeState({
    this.status = ApiStatus.initial,
    this.pokemons = const <Pokemon>[],
    this.cachedPokemons = const <Pokemon>[],
    this.pokemonDetail,
    this.offset = 0,
  });

  HomeState copywith({
    ApiStatus? status,
    List<Pokemon>? pokemons,
    List<Pokemon>? cachedPokemons,
    PokemonDetail? pokemonDetail,
    int? offset,
  }) {
    return HomeState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      cachedPokemons: cachedPokemons ?? this.cachedPokemons,
      pokemonDetail: pokemonDetail ?? this.pokemonDetail,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => [
    status,
    pokemons,
    cachedPokemons,
    pokemonDetail,
    offset,
  ];
}
