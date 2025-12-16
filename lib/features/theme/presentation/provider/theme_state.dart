import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class ThemeState extends Equatable {
  final ThemeMode theme;
  final Locale locale;
  final ApiStatus status;
  const ThemeState({
    this.status = ApiStatus.initial,
    this.theme = ThemeMode.system,
    this.locale = const Locale('en'),
  });

  ThemeState copywith({ApiStatus? status, ThemeMode? theme, Locale? locale}) {
    return ThemeState(
      status: status ?? this.status,
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [status, theme, locale];
}
