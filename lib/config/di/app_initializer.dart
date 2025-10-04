
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/features/home/presentation/bloc/category/category_cubit.dart';
import '../../features/home/presentation/bloc/note/note_cubit.dart';
import '/core/utils/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../core/navigation/navigator.dart';
import '../../core/storage/storage_client.dart';
import '../../core/utils/observers.dart';
import '../../features/home/repository/repository.dart';
import '../flavor/build_variables.dart';
import '/core/storage/shared_prefs_impl.dart';
import '/features/home/presentation/bloc/theme/theme_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppInitializer {
  static late GetIt instanceLocator;

  AppInitializer._();

  void close() {
    instanceLocator.reset();
  }

  static Future<void> init() async {
    instanceLocator = GetIt.instance;
    Bloc.observer = AppBlocObserver();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Bloc.observer = AppBlocObserver();
    await ScreenUtil.ensureScreenSize();
    // BuildVariables.init();
    initialize();
  }

  static void initialize() {
    initializeNavigator();
    initializeLocalDataSources();
    initializeHelper();
    initRepos();
    initBlocs();
  }

  static void initializeHelper() {
    instanceLocator.registerLazySingleton<IWidgetHelper>(
      () => WidgetHelper(),
    );
  }

  static void initializeNavigator() {
    instanceLocator.registerLazySingleton<NavigationService>(
      () => GoRouterNavigatorImpl(navigatorKey),
    );
  }



  static void initializeLocalDataSources() {
    instanceLocator.registerLazySingleton<StorageClient>(
      () => PrefsStorageImpl(),
    );

  }

  static void initBlocs() {
    instanceLocator.registerLazySingleton<ThemeBloc>(
      () => ThemeBloc(
        instanceLocator.get<HomeRepository>(),
      ),
    );

      instanceLocator.registerLazySingleton<NoteCubit>(
      () => NoteCubit(
       repository:  instanceLocator(),
      ),
    );

        instanceLocator.registerLazySingleton<CategoryCubit>(
      () => CategoryCubit(
       repository:  instanceLocator(),
      ),
    );

  

  }

  static void initRepos() {

    instanceLocator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        instanceLocator.get<StorageClient>(),
     
      ),
    );

  }


}
