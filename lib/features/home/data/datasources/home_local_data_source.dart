import '../../../../config/local_storage/app_local_prefs.dart';
import '../../domain/entities/pokemon.dart';
import '../models/pokemon_model.dart';

abstract class HomeLocalDataSource {
  List<PokemonModel> getPokemonList();
  Future<void> storePokemonList({required List<Pokemon> pokemons});
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final AppLocalPrefs pokemonDBPref;
  HomeLocalDataSourceImpl({required this.pokemonDBPref});

  /// Get all Pokemon List
  @override
  List<PokemonModel> getPokemonList() {
    List<PokemonModel> allPokemons = [];
    final data = pokemonDBPref.readAll();
    if (data.isNotEmpty) {
      allPokemons = data.entries.map((e) {
        return PokemonModel.fromJson(Map<String, dynamic>.from(e.value));
      }).toList();
    }
    return allPokemons;
  }

  /// Store Pokemons
  @override
  Future<void> storePokemonList({required List<Pokemon> pokemons}) async {
    for (int i = 0; i < pokemons.length; i++) {
      Map<String, dynamic> data = pokemons[i].toJson();
      await pokemonDBPref.createOrUpdate("$i", data);
    }
  }
}
