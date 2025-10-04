part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeChanged extends ThemeState {}

final class ThemeLoading extends ThemeState {}
