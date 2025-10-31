import 'dart:convert';

import 'package:flutter/material.dart';
import '../page/unknown_page.dart';
import 'AppRouter.dart';

export 'dlog.dart';
export 'AppRouter.dart';

/// 路由管理
class AppNavigator {
  static final AppNavigator _instance = AppNavigator._();
  AppNavigator._();
  factory AppNavigator() => _instance;
  static AppNavigator get instance => _instance;

  static bool isLog = false;

  /// 全局 NavigatorKey
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// 当前 Navigator
  static NavigatorState get navigator => navigatorKey.currentState!;

  /// 未知页面
  static WidgetBuilder unknownPageBuilder = (context) => const UnknownPage();

  static Map<String, WidgetBuilder> get routeMap => AppRouter.routeMap;

  /// 匿名跳转（类似 Get.to）
  static Future<T?> to<T>(Widget page, {Object? arguments}) {
    return navigator.push<T>(
      MaterialPageRoute(builder: (_) => page, settings: RouteSettings(arguments: arguments)),
    );
  }

  /// 命名跳转（类似 Get.toNamed）
  static Future<T?>? toNamed<T>(String routeName, {Object? arguments}) {
    final builder = routeMap[routeName] ?? unknownPageBuilder;
    return navigator.push<T>(
      MaterialPageRoute(builder: builder, settings: RouteSettings(name: routeName, arguments: arguments)),
    );
  }

  /// 替换当前页面（类似 Get.off）
  static Future<T?> off<T>(Widget page, {Object? arguments}) {
    return navigator.pushReplacement<T, T>(
      MaterialPageRoute(builder: (_) => page, settings: RouteSettings(arguments: arguments)),
    );
  }

  /// 命名替换（类似 Get.offNamed）
  static Future<T?>? offNamed<T>(String routeName, {Object? arguments}) {
    final builder = routeMap[routeName] ?? unknownPageBuilder;
    return navigator.pushReplacement<T, T>(
      MaterialPageRoute(builder: builder, settings: RouteSettings(name: routeName, arguments: arguments)),
    );
  }

  static void until(RoutePredicate predicate) {
    return navigator.popUntil(predicate);
  }

  static Future<T?>? offUntil<T>(Route<T> page, RoutePredicate predicate) {
    return navigator.pushAndRemoveUntil<T>(page, predicate);
  }

  /// **Navigation.pushNamedAndRemoveUntil()** shortcut.
  static Future<T?>? offNamedUntil<T>(
    String page,
    RoutePredicate predicate, {
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }

    return navigator.pushNamedAndRemoveUntil<T>(
      page,
      predicate,
      arguments: arguments,
    );
  }

  /// **Navigation.popAndPushNamed()** shortcut.
  static Future<T?>? offAndToNamed<T>(
    String page, {
    dynamic arguments,
    dynamic result,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }
    return navigator.popAndPushNamed(
      page,
      arguments: arguments,
      result: result,
    );
  }

  /// **Navigation.removeRoute()** shortcut.
  static void removeRoute(Route<dynamic> route) {
    return navigator.removeRoute(route);
  }

  /// 清空栈并跳转（类似 Get.offAll）
  static Future<T?> offAll<T>(Widget page, {Object? arguments}) {
    return navigator.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page, settings: RouteSettings(arguments: arguments)),
      (route) => false,
    );
  }

  /// 命名清栈跳转（类似 Get.offAllNamed）
  static Future<T?>? offAllNamed<T>(String routeName, {Object? arguments}) {
    final builder = routeMap[routeName] ?? unknownPageBuilder;

    return navigator.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: builder, settings: RouteSettings(name: routeName, arguments: arguments)),
      (route) => false,
    );
  }

  /// 返回上一级（类似 Get.back）
  static void back<T>([T? result]) {
    if (!navigator.canPop()) {
      return;
    }
    return navigator.pop(result);
  }

  /// **Navigation.popUntil()** (with predicate) shortcut .
  static void close(int times) {
    if (times < 1) {
      times = 1;
    }
    var count = 0;
    var back = navigator.popUntil((route) => count++ == times);
    return back;
  }
}
