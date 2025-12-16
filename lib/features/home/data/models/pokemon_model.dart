import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({required super.name, required super.url});

  /// JSON → Model
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(name: json['name'] ?? '', url: json['url'] ?? '');
  }
}
