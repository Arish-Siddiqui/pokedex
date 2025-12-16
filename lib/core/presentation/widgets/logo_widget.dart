import 'package:flutter/material.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_constants.dart';

class LogoWidget extends StatelessWidget {
  final double? size;
  const LogoWidget({this.size, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              offset: Offset(0, 2),
              blurRadius: 8.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        height: size ?? screenHeight! * 0.15,
        width: size ?? screenHeight! * 0.15,
        child: Image.asset(AppImages.pokeball, fit: BoxFit.fitHeight),
      ),
    );
  }
}
