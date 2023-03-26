import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:photo_headquarters/router.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_headquarters/config/theme.dart';
import 'package:photo_headquarters/services/google_photos.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter router;
  List<String> photoUrls = <String>[];
  String message = 'You need to sign in to see your photos.';
  @override
  initState() {
    super.initState();
    router = appRouter();
    // var google = GooglePhotosService();
    GooglePhotosService.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      setState(() {
        GooglePhotosService.curUser = account;
      });
      if (account != null) {
        // auth.AuthClient client = await google.handleGetPhotos();
        setState(() {});
        List<String> photos = await GooglePhotosService.getPhotoUrls();
      }
    });
    GooglePhotosService.handleSignIn();
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
