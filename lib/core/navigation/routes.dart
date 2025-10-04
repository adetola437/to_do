import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/features/home/presentation/controllers/create_task.dart';


import '/config/di/app_initializer.dart';
import '/features/home/presentation/presentation.dart';

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  // initialLocation: HomeScreen.route, 
  routes: [
    GoRoute(
      path: HomeScreen.route,
      pageBuilder: (context, state) => buildPage(const HomeScreen()),
      routes: [
   
      ]
    ),
      GoRoute(
      path: CreateTaskScreen.route,
      pageBuilder: (context, state) => buildPage(const CreateTaskScreen()),
      routes: [
   
      ]
    ),
  
   

   


  ],
);


Page buildPage(Widget child) {
  return Platform.isIOS
      ? CupertinoPage(child: child)
      : MaterialPage(child: child);
}
