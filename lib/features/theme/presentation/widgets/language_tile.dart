import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  final void Function()? onTap;
  final Map<String, dynamic> languageData;
  final Locale selectedLanguage;
  const LanguageTile({
    required this.onTap,
    required this.languageData,
    required this.selectedLanguage,
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
              selectedLanguage.languageCode ==
                      (languageData["locale"] as Locale).languageCode
                  ? Icons.check_circle_rounded
                  : Icons.circle_outlined,
              size: 22.0,
              color: theme.colorScheme.tertiary,
            ),
            const SizedBox(width: 12.0),
            Text(
              languageData["name"],
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
