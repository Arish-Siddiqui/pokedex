import 'dart:isolate';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../config/local_storage/app_local_prefs.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/pokemon.dart';
import '../models/pokemon_model.dart';

abstract class HomeLocalDataSource {
  Future<List<PokemonModel>> getPokemonList();
  Future<void> storePokemonList({required List<Pokemon> pokemons});
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  // final AppLocalPrefs pokemonDBPref;
  HomeLocalDataSourceImpl(
    // {required this.pokemonDBPref}
  );

  /// Get all Pokemon List
  @override
  Future<List<PokemonModel>> getPokemonList() async {
    final pokemonDB = AppLocalPrefs(pokemonBox);
    await pokemonDB.init();
    List<PokemonModel> allPokemons = [];
    final data = pokemonDB.readAll();
    if (data.isNotEmpty) {
      allPokemons = data.entries.map((e) {
        return PokemonModel.fromJson(Map<String, dynamic>.from(e.value));
      }).toList();
    }
    await pokemonDB.close();
    return allPokemons;
  }

  /// Store Pokemons
  @override
  Future<void> storePokemonList({required List<Pokemon> pokemons}) async {
    final List<Map<String, dynamic>> pokemonsJson = pokemons
        .map<Map<String, dynamic>>((e) => e.toJson())
        .toList();
    final dir = await getApplicationDocumentsDirectory();

    await Isolate.run(() async {
      await _hiveIsolateEntry(pokemonsJson, dir.path);
    });
  }

  Future<void> _hiveIsolateEntry(
    List<Map<String, dynamic>> pokemonsJson,
    String hivePath,
  ) async {
    Hive.init(hivePath);
    final box = await Hive.openBox(pokemonBox);

    for (int i = 0; i < pokemonsJson.length; i++) {
      await box.put('$i', pokemonsJson[i]);
    }

    await box.close();
  }
}
