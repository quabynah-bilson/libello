import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libello/core/constants.dart';
import 'package:libello/core/router/route.gr.dart';
import 'package:libello/core/theme.dart';
import 'package:libello/features/shared/presentation/manager/auth_cubit.dart';
import 'package:libello/features/shared/presentation/manager/note_cubit.dart';
import 'package:libello/features/shared/presentation/widgets/dismiss.keyboard.dart';

class LibelloApp extends StatefulWidget {
  const LibelloApp({Key? key}) : super(key: key);

  @override
  State<LibelloApp> createState() => _LibelloAppState();
}

class _LibelloAppState extends State<LibelloApp> {
  final _router = LibelloAppRouter();

  @override
  Widget build(BuildContext context) => DismissKeyboard(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => NoteCubit()),
            BlocProvider(create: (context) => AuthCubit()),
          ],
          child: MaterialApp.router(
            scrollBehavior: const CupertinoScrollBehavior(),
            debugShowCheckedModeBanner: false,
            title: kAppName,
            theme: ThemeConfig.kLightThemeData(context),
            darkTheme: ThemeConfig.kDarkThemeData(context),
            themeMode: ThemeMode.system,
            routerDelegate: _router.delegate(),
            routeInformationParser: _router.defaultRouteParser(),
          ),
        ),
      );
}
