import 'package:flutter/material.dart';

class ThemeTile extends StatelessWidget {
  final void Function()? onTap;
  final Map<String, dynamic> themeData;
  final ThemeMode selectedTheme;
  const ThemeTile({
    required this.onTap,
    required this.themeData,
    required this.selectedTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
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
            Icon(
              selectedTheme == themeData["theme"]
                  ? Icons.check_circle_rounded
                  : Icons.circle_outlined,
              size: 22.0,
              color: theme.colorScheme.tertiary,
            ),
            const SizedBox(width: 12.0),
            Text(
              themeData["name"],
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
