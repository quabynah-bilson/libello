import 'package:flutter/material.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/core/theme.dart';


class LibelloApp extends StatefulWidget {
  const LibelloApp({Key? key}) : super(key: key);

  @override
  State<LibelloApp> createState() => _LibelloAppState();
}

class _LibelloAppState extends State<LibelloApp> {
  final _router = LibelloAppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: ThemeConfig.kLightThemeData(context),
      darkTheme: ThemeConfig.kDarkThemeData(context),
      themeMode: ThemeMode.dark,
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
}
