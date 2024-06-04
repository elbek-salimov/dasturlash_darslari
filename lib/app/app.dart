import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dasturlash_darslari/data/blocs/banner/banner_event.dart';
import 'package:dasturlash_darslari/data/repository/banner/banner_repository.dart';
import 'package:dasturlash_darslari/data/repository/course/course_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/blocs/auth/auth_bloc.dart';
import '../data/blocs/banner/banner_bloc.dart';
import '../data/blocs/course/course_bloc.dart';
import '../data/blocs/course/course_event.dart';
import '../data/blocs/navbar/navbar_bloc.dart';
import '../data/repository/auth/auth_repository.dart';
import '../screens/routes.dart';
import '../utils/theme/app_theme.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (_) => BannerRepository(),
        ),
        RepositoryProvider(
          create: (_) => CourseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(CheckAuthenticationEvent()),
          ),
          BlocProvider(create: (context) => NavBarBloc()),
          BlocProvider(
            create: (context) => BannerBloc(
              bannerRepository: context.read<BannerRepository>(),
            )..add(GetBannerEvent()),
          ),
          BlocProvider(
            create: (context) => CourseBloc(
              courseRepository: context.read<CourseRepository>(),
            )..add(GetCourseEvent()),
          ),
        ],
        child: AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: AdaptiveThemeMode.system,
          builder: (theme, darkTheme) {
            return MaterialApp(
              theme: theme,
              darkTheme: darkTheme,
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splash,
              onGenerateRoute: AppRoutes.generateRoute,
              locale: context.locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
