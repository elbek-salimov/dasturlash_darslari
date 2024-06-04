import 'package:dasturlash_darslari/data/models/course/course_model.dart';
import 'package:dasturlash_darslari/data/models/course/lesson_model.dart';
import 'package:dasturlash_darslari/data/models/course/module_model.dart';
import 'package:dasturlash_darslari/screens/home/sidebar/side_bar_menu.dart';
import 'package:dasturlash_darslari/screens/profile/profile_screen.dart';
import 'package:dasturlash_darslari/screens/rank/rank_screen.dart';
import 'package:dasturlash_darslari/screens/search/search_screen.dart';
import 'package:dasturlash_darslari/screens/splash/splash_screen.dart';
import 'package:dasturlash_darslari/screens/splash/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'auth/forgot_password_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'home/home_screen.dart';
import 'home/lesson/lesson_screen.dart';
import 'home/module/module_screen.dart';
import 'home/notification/notification_screen.dart';
import 'home/topic/topic_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return navigate(const SplashScreen());
      case RouteNames.start:
        return navigate(const StartScreen());
      case RouteNames.login:
        return PageTransition(
            child: const LoginScreen(),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case RouteNames.signup:
        return PageTransition(
            child: const RegisterScreen(),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case RouteNames.forgotPassword:
        return PageTransition(
            child: const ForgotPasswordScreen(),
            type: PageTransitionType.fade,
            alignment: Alignment.center);
      case RouteNames.sideBar:
        return navigate(const SideBarMenu());
      case RouteNames.home:
        return navigate(const HomeScreen());
      case RouteNames.search:
        return navigate(const SearchScreen());
      case RouteNames.rank:
        return navigate(const RankScreen());
      case RouteNames.profile:
        return navigate(const ProfileScreen());
      case RouteNames.notification:
        return PageTransition(
            child: const NotificationScreen(),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case RouteNames.module:
        return PageTransition(
            child: ModuleScreen(activeIndex: settings.arguments as int),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case RouteNames.lesson:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return PageTransition(
            child: LessonScreen(
              selectedModule: data['selectedModule'] as ModuleModel,
              selectedCourse: data['selectedCourse'] as CourseModel,
            ),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case RouteNames.topic:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return PageTransition(
            child: TopicScreen(
              selectedLesson: data['selectedLesson'] as LessonModel,
              selectedCourse: data['selectedCourse'] as CourseModel,
            ),
            type: PageTransitionType.scale,
            alignment: Alignment.center);

      // case RouteNames.updateEducation:
      //   {
      //     Map<String, dynamic> data =
      //     settings.arguments as Map<String, dynamic>;
      //
      //     return navigate(
      //       UpdateEducationExperience(
      //         educationModel: data["education"] as EducationModel,
      //         index: data["index"] as int,
      //       ),
      //     );
      //   }

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text('This page does not exist'),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);
}

class RouteNames {
  static const String splash = '/';
  static const String start = 'start_route';
  static const String login = '/login_route';
  static const String signup = '/signup_route';
  static const String forgotPassword = '/forgot_password_route';
  static const String sideBar = '/sidebar_route';
  static const String navBar = '/navbar_route';
  static const String home = '/home_route';
  static const String search = '/search_route';
  static const String rank = '/rank_route';
  static const String profile = '/profile_route';
  static const String notification = '/notification_route';
  static const String module = '/module_route';
  static const String lesson = '/lesson_route';
  static const String topic = '/topic_route';
}
