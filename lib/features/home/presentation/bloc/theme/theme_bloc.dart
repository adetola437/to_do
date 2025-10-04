import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '/features/home/repository/repository.dart';
import '/main.dart';

import '/core/theme/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final HomeRepository repository;
  bool lightMode = true;
  ThemeBloc(this.repository) : super(ThemeLoading()) {
    init();
    on<ThemeToggleEvent>((event, emit) => _toggleTheme(event, emit));
  }

  void init() async {
    final isDark = await repository.isDarkMode();
    var currentThemeMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    if (isDark == null) {
      themeNotifier.value =
          currentThemeMode == Brightness.dark ? darkTheme : lightTheme;
    } else {
      if (isDark == true) {
        themeNotifier.value = darkTheme;
        lightMode = false;
      }
    }
  }

  _toggleTheme(ThemeToggleEvent event, Emitter<ThemeState> emit) async {
    lightMode = !lightMode;
    if (lightMode) {
      themeNotifier.value = lightTheme;
    } else {
      themeNotifier.value = darkTheme;
    }
    await repository.toggleTheme(!lightMode);
  }
}
