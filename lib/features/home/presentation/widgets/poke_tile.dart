import 'package:flutter/material.dart';

import '../../../../config/router/router.dart';
import '../../domain/entities/pokemon.dart';

class PokeTile extends StatelessWidget {
  final Pokemon pokemon;
  const PokeTile({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Head.to(AppPages.pokeDetail, arguments: pokemon),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              offset: Offset(0, 2),
              blurRadius: 8.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                pokemon.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.scrim,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor,
                    offset: Offset(0, 2),
                    blurRadius: 8.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
