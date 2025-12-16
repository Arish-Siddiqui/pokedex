import '../../domain/entities/pokemon_detail.dart';

class PokemonDetailModel extends PokemonDetail {
  const PokemonDetailModel({
    required super.id,
    required super.name,
    required super.baseExperience,
    required super.height,
    required super.weight,
    required super.order,
    required super.abilities,
    required super.forms,
    required super.moves,
    required super.species,
    required super.sprites,
    required super.stats,
    required super.types,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      order: json['order'],

      abilities: (json['abilities'] as List)
          .map(
            (a) => Ability(
              ability: NamedApiResource(
                name: a['ability']['name'],
                url: a['ability']['url'],
              ),
              isHidden: a['is_hidden'],
              slot: a['slot'],
            ),
          )
          .toList(),

      forms: (json['forms'] as List)
          .map((f) => Form(name: f['name'], url: f['url']))
          .toList(),

      moves: (json['moves'] as List)
          .map(
            (m) => Move(
              move: NamedApiResource(
                name: m['move']['name'],
                url: m['move']['url'],
              ),
            ),
          )
          .toList(),

      species: Species(
        name: json['species']['name'],
        url: json['species']['url'],
      ),

      sprites: Sprites(other: json['sprites']['other']),

      stats: (json['stats'] as List)
          .map(
            (s) => Stat(
              baseStat: s['base_stat'],
              effort: s['effort'],
              stat: NamedApiResource(
                name: s['stat']['name'],
                url: s['stat']['url'],
              ),
            ),
          )
          .toList(),

      types: (json['types'] as List)
          .map(
            (t) => Type(
              slot: t['slot'],
              type: NamedApiResource(
                name: t['type']['name'],
                url: t['type']['url'],
              ),
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "base_experience": baseExperience,
      "height": height,
      "weight": weight,
      "order": order,

      "abilities": abilities
          .map(
            (a) => {
              "ability": {"name": a.ability.name, "url": a.ability.url},
              "is_hidden": a.isHidden,
              "slot": a.slot,
            },
          )
          .toList(),

      "forms": forms.map((f) => {"name": f.name, "url": f.url}).toList(),

      "moves": moves
          .map(
            (m) => {
              "move": {"name": m.move.name, "url": m.move.url},
            },
          )
          .toList(),

      "species": {"name": species.name, "url": species.url},

      "sprites": {"other": sprites.other},

      "stats": stats
          .map(
            (s) => {
              "base_stat": s.baseStat,
              "effort": s.effort,
              "stat": {"name": s.stat.name, "url": s.stat.url},
            },
          )
          .toList(),

      "types": types
          .map(
            (t) => {
              "slot": t.slot,
              "type": {"name": t.type.name, "url": t.type.url},
            },
          )
          .toList(),
    };
  }
}
