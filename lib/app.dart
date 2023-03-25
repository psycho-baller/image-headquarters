import 'package:flutter/material.dart';
import 'package:photo_headquarters/router.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_headquarters/config/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter router;

  @override
  initState() {
    super.initState();
    router = appRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Photo Headquarters',
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      // themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
