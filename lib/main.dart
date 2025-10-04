
import 'dart:ui';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';


import 'package:flutter/material.dart';
import 'package:to_do/features/home/presentation/bloc/category/category_cubit.dart';
import 'package:to_do/features/home/presentation/bloc/note/note_cubit.dart';

import '../config/di/app_initializer.dart';

import 'core/navigation/routes.dart';
import 'core/theme/theme.dart';

import 'features/home/presentation/bloc/theme/theme_bloc.dart';


ValueNotifier<ThemeData> themeNotifier = ValueNotifier(lightTheme);
ValueNotifier<bool> biometricsNotifier = ValueNotifier(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  runApp(
     const MyApp(),
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppInitializer.instanceLocator.get<ThemeBloc>(),
          lazy: false,
        ),
         BlocProvider(
          create: (context) => GetIt.I.get<NoteCubit>(),
          lazy: false,
        ),

         BlocProvider(
          create: (context) => GetIt.I.get<CategoryCubit>(),
          lazy: false,
        ),

      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: false,
        fontSizeResolver: FontSizeResolvers.height,
        rebuildFactor: (old, data) {
          return true;
        },
        builder: (context, child) {
          ResponsiveBreakpoints.builder(
            child: child ?? const SizedBox(),
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                // ignore: deprecated_member_use
                textScaleFactor:
                    MediaQuery.of(context).size.width > 428 ? 1 : 1.05),
            child: ValueListenableBuilder(
                valueListenable: themeNotifier,
                builder: (context, ThemeData theme, child) {
                  return SkeletonizerConfig(
                    data: theme == lightTheme
                        ? const SkeletonizerConfigData.light()
                        : const SkeletonizerConfigData.dark(),
                    child: MaterialApp.router(
                       localizationsDelegates: const [

    FlutterQuillLocalizations.delegate,
  ],
                      debugShowCheckedModeBanner: false,
                     
                      routerConfig: router,
                      theme: theme,
                    ),
                  );
                },
              ),
          );
        },
      ),
    );
  }
}
