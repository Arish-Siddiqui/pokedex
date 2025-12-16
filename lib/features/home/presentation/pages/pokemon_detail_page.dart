import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../config/multi_language/multi_language.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../provider/home_provider.dart';

class PokemonDetailPage extends HookConsumerWidget {
  final Pokemon pokemon;
  const PokemonDetailPage({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final loc = ref.watch(localizationProvider);

    final state = ref.watch(homeProvider);

    final asyncValue = ref.watch(getPokemonDetailProvider(pokemon.url));

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          loc.translate(TranslationConst.pokemonDetail),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
      ),
      body: asyncValue.when(
        data: (_) {
          final String moves =
              state.pokemonDetail?.moves
                  .map((Move m) => m.move.name)
                  .join(", ") ??
              "";
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Image.network(
                state.pokemonDetail?.sprites.other["home"]["front_shiny"] ?? "",
                height: screenHeight! * 0.45,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  state.pokemonDetail?.name ?? "",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Wrap(
                  runSpacing: 12.0,
                  spacing: 12.0,
                  children:
                      state.pokemonDetail?.types
                          .map<Container>(
                            (Type t) => Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 6.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: theme.colorScheme.tertiary,
                                ),
                              ),
                              child: Text(
                                t.type.name,
                                style: TextStyle(
                                  color: theme.colorScheme.tertiary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(
                    color: theme.colorScheme.scrim.withValues(alpha: 0.45),
                  ),
                  gradient: LinearGradient(
                    colors: theme.brightness == Brightness.light
                        ? [
                            AppColors.greyLight.withValues(alpha: 0.5),
                            AppColors.cardBackground.withValues(alpha: 0.5),
                          ]
                        : [
                            AppColors.deepBlack.withValues(alpha: 0.5),
                            AppColors.darkCard.withValues(alpha: 0.5),
                          ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 4.0,
                        children: [
                          Text("Height"),
                          Text(
                            state.pokemonDetail == null
                                ? ""
                                : "${state.pokemonDetail?.height.toString()}m",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 4.0,
                        children: [
                          Text("Weight"),
                          Text(
                            state.pokemonDetail == null
                                ? ""
                                : "${state.pokemonDetail?.weight.toString()}kg",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Moves",
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                moves,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        },
        loading: () => const CustomLoader(),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
