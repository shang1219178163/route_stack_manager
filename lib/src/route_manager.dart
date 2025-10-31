//
//  RouteManager.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 09:51.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

/// 路由堆栈管理器
class RouteManager {
  static final RouteManager _instance = RouteManager._();
  RouteManager._();
  factory RouteManager() => _instance;
  static RouteManager get instance => _instance;

  /// 是否打印日志
  bool isDebug = false;

  /// 监听(跳转前)列表
  final List<void Function({Route? from, Route? to})> _beforelisteners = [];

  // 添加监听
  void addRouteBeforeListener(void Function({Route? from, Route? to}) cb) {
    if (_beforelisteners.contains(cb)) {
      return;
    }
    _beforelisteners.add(cb);
  }

  // 移除监听
  void removeRouteBeforeListener(void Function({Route? from, Route? to}) cb) {
    _beforelisteners.remove(cb);
  }

  /// 通知所有监听器
  void notifyRouteBeforeListeners({required Route? from, required Route? to}) {
    for (var ltr in _beforelisteners) {
      ltr(from: from, to: to);
    }
  }

  /// 监听列表
  final List<void Function({Route? from, Route? to})> _listeners = [];

  // 添加监听
  void addListener(void Function({Route? from, Route? to}) cb) {
    if (_listeners.contains(cb)) {
      return;
    }
    _listeners.add(cb);
  }

  // 移除监听
  void removeListener(void Function({Route? from, Route? to}) cb) {
    _listeners.remove(cb);
  }

  /// 通知所有监听器
  void notifyListeners({required Route? from, required Route? to}) {
    for (var ltr in _listeners) {
      ltr(from: from, to: to);
    }
  }

  /// 所有路由堆栈
  final List<Route<Object?>> _routes = [];

  /// 当前路由堆栈
  List<Route<Object?>> get routes => _routes;

  /// 当前 PageRoute 路由堆栈
  List<PageRoute<Object?>> get pageRoutes => _routes.whereType<PageRoute>().toList();

  /// 当前 DialogRoute 路由堆栈
  List<RawDialogRoute<Object?>> get dialogRoutes => _routes.whereType<RawDialogRoute>().toList();

  /// 当前 ModalBottomSheetRoute 路由堆栈
  List<ModalBottomSheetRoute<Object?>> get sheetRoutes => _routes.whereType<ModalBottomSheetRoute>().toList();

  /// 当前路由名堆栈
  List<String?> get routeNames => routes.map((e) => e.settings.name).toList();

  /// 之前路由
  Route<Object?>? get preRoute => _preRoute;

  /// 之前路由
  Route<Object?>? _preRoute;

  /// 之前路由 name
  String? get preRouteName => preRoute?.settings.name;

  /// 当前路由
  Route<Object?>? get currentRoute => routes.isEmpty ? null : routes.last;

  /// 当前路由 name
  String? get currentRouteName => currentRoute?.settings.name;

  /// 最近的 PopupRoute 类型路由
  PopupRoute? get popupRoute {
    for (int i = routes.length - 1; i >= 0; i--) {
      final e = routes[i];
      if (e is PopupRoute) {
        return e;
      }
    }
    return null;
  }

  /// 当前路由类型是 PopupRoute
  bool get isPopupOpen => popupRoute != null;

  /// 路由堆栈包含 DialogRoute 类型
  bool get isDialogOpen => popupRoute is DialogRoute;

  /// 路由堆栈包含 ModalBottomSheetRoute 类型
  bool get isSheetOpen => popupRoute is ModalBottomSheetRoute;

  /// 是否存在路由堆栈中
  bool contain(String routeName) {
    return routeNames.contains(routeName);
  }

  /// 路由对应的参数
  Object? getArguments(String routeName) {
    final index = pageRoutes.indexWhere((e) => e.settings.name == routeName);
    if (index == -1) {
      return null;
    }
    final route = pageRoutes[index];
    return route;
  }

  /// 入栈
  void push(Route<dynamic> route) {
    if (_routes.isEmpty || _routes.isNotEmpty && _routes.last != route) {
      _routes.add(route);
    }
  }

  /// 出栈
  void pop(Route<dynamic> route) {
    _routes.remove(route);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDebug'] = isDebug;
    data['routes'] = routes.map((e) => e.toString()).toList();
    data['pageRoutes'] = pageRoutes.map((e) => e.toString()).toList();
    if (dialogRoutes.isNotEmpty) {
      data['dialogRoutes'] = dialogRoutes.map((e) => e.toString()).toList();
    }
    if (sheetRoutes.isNotEmpty) {
      data['sheetRoutes'] = sheetRoutes.map((e) => e.toString()).toList();
    }
    data['routeNames'] = routeNames;
    data['preRoute'] = preRoute.toString();
    data['preRouteName'] = preRouteName;
    data['currentRouteName'] = currentRouteName;
    data['popupRoute'] = popupRoute.toString();
    data['isPopupOpen'] = isPopupOpen;
    data['isDialogOpen'] = isDialogOpen;
    data['isSheetOpen'] = isSheetOpen;
    return data;
  }

  @override
  String toString() {
    const encoder = JsonEncoder.withIndent('  ');
    final descption = encoder.convert(toJson());
    return "$runtimeType: $descption";
  }

  void logRoutes() {
    if (!isDebug) {
      return;
    }

    developer.log(toString());
  }
}

/// 堆栈管理器路由监听器
class RouteManagerObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouteManager()._preRoute = previousRoute;
    RouteManager().notifyRouteBeforeListeners(from: previousRoute, to: route);

    super.didPush(route, previousRoute);
    RouteManager().push(route);

    RouteManager().notifyListeners(from: previousRoute, to: route);
    RouteManager().logRoutes();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouteManager()._preRoute = route;
    RouteManager().notifyRouteBeforeListeners(from: route, to: previousRoute);

    super.didPop(route, previousRoute);
    RouteManager().pop(route);

    RouteManager().notifyListeners(from: route, to: previousRoute);
    RouteManager().logRoutes();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    RouteManager()._preRoute = oldRoute;
    RouteManager().notifyRouteBeforeListeners(from: oldRoute, to: newRoute);

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) RouteManager().pop(oldRoute);
    if (newRoute != null) RouteManager().push(newRoute);

    RouteManager().notifyListeners(from: oldRoute, to: newRoute);
    RouteManager().logRoutes();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouteManager()._preRoute = route;
    RouteManager().notifyRouteBeforeListeners(from: previousRoute, to: route);

    super.didRemove(route, previousRoute);
    RouteManager().pop(route);

    RouteManager().notifyListeners(from: previousRoute, to: route);
    RouteManager().logRoutes();
  }
}

// abstract mixin class RouteBeforeMixin {
//   void routerBeforeChaned({Route? from, Route? to}) {}
// }
