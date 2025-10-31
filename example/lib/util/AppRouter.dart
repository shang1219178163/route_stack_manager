import 'package:example/page/home_page.dart';
import 'package:example/page/page_five.dart';
import 'package:example/page/page_four.dart';
import 'package:example/page/page_one.dart';
import 'package:example/page/page_three.dart';
import 'package:example/page/page_two.dart';
import 'package:example/page/unknown_page.dart';
import 'package:flutter/cupertino.dart';

export 'AppNavigator.dart';

/// 路由页面
class AppPage {
  AppPage({
    required this.name,
    required this.page,
  });

  final String name;

  final WidgetBuilder page;
}

/// 路由定义
class AppRouter {
  static const String initial = homePage;

  static const String unknown = '/unknown';
  static const String homePage = '/homePage';
  static const String pageOne = '/pageOne';
  static const String pageTwo = '/pageTwo';
  static const String pageThree = '/pageThree';
  static const String pageFour = '/pageFour';
  static const String pageFive = '/pageFive';

  static Map<String, WidgetBuilder> routeMap = Map<String, WidgetBuilder>.fromEntries(
    routes.map((e) => MapEntry<String, WidgetBuilder>(e.name, e.page)),
  );

  static final List<AppPage> routes = [
    AppPage(
      name: AppRouter.unknown,
      page: (context) => const UnknownPage(),
    ),
    AppPage(
      name: AppRouter.homePage,
      page: (context) => const HomePage(),
    ),
    AppPage(
      name: AppRouter.pageOne,
      page: (context) => const PageOne(),
    ),
    AppPage(
      name: AppRouter.pageTwo,
      page: (context) => const PageTwo(),
    ),
    AppPage(
      name: AppRouter.pageThree,
      page: (context) => const PageThree(),
    ),
    AppPage(
      name: AppRouter.pageFour,
      page: (context) => const PageFour(),
    ),
    AppPage(
      name: AppRouter.pageFive,
      page: (context) => const PageFive(),
    ),
  ];
}
