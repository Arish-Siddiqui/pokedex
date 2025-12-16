class PokemonDetail {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final int weight;
  final int order;

  final List<Ability> abilities;
  final List<Form> forms;
  final List<Move> moves;
  final Species species;
  final Sprites sprites;
  final List<Stat> stats;
  final List<Type> types;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.order,
    required this.abilities,
    required this.forms,
    required this.moves,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
  });
}

// ---- Sub Entities ----

class Ability {
  final NamedApiResource ability;
  final bool isHidden;
  final int slot;

  const Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });
}

class Form {
  final String name;
  final String url;

  const Form({required this.name, required this.url});
}

class Move {
  final NamedApiResource move;

  const Move({required this.move});
}

class Species {
  final String name;
  final String url;

  const Species({required this.name, required this.url});
}

class Sprites {
  final Map<String, dynamic> other; // Keep sprites as-is

  const Sprites({required this.other});
}

class Stat {
  final int baseStat;
  final int effort;
  final NamedApiResource stat;

  const Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });
}

class Type {
  final int slot;
  final NamedApiResource type;

  const Type({required this.slot, required this.type});
}

// Shared resource structure
class NamedApiResource {
  final String name;
  final String url;

  const NamedApiResource({required this.name, required this.url});
}
