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

  /// 路由堆栈(满足 filterRoute 的)
  final List<Route<dynamic>> _routes = [];

  /// 所有路由堆栈
  final List<Route<dynamic>> _allRoutes = [];

  /// 当前路由堆栈
  List<Route<dynamic>> get routes => _routes;

  /// 当前路由名堆栈
  List<String?> get routeNames => routes.map((e) => e.settings.name).toList();

  /// 之前路由
  Route<dynamic>? preRoute;

  /// 当前路由
  String? get preRouteName => preRoute?.settings.name;

  /// 当前路由
  Route<dynamic>? get currentRoute => routes.isEmpty ? null : routes.last;

  /// 当前路由
  String? get current => currentRoute?.settings.name;

  /// PopupRoute 类型路由
  PopupRoute? get popupRoute {
    // for (int i = routes.length - 1; i >= 0; i--) {
    //   final e = routes[i];
    //   if (e is PopupRoute) {
    //     return e;
    //   }
    // }

    for (int i = _allRoutes.length - 1; i >= 0; i--) {
      final e = _allRoutes[i];
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

  /// 进出堆栈过滤条件(默认仅支持PageRoute, 过滤弹窗)
  bool Function(Route<dynamic> route) filterRoute =
      (route) => route is PageRoute && route.settings.name != null;

  /// 更新回调
  ValueChanged<RouteManager>? onChanged;

  /// 是否存在路由堆栈中
  bool contain(String routeName) {
    return routeNames.contains(routeName);
  }

  /// 路由对应的参数
  Object? getArguments(String routeName) {
    final route = routes.firstWhere((e) => e.settings.name == routeName);
    return route.settings.arguments;
  }

  /// 入栈
  void push(Route<dynamic> route) {
    if (_allRoutes.isEmpty ||
        _allRoutes.isNotEmpty && _allRoutes.last != route) {
      _allRoutes.add(route);
    }

    if (!filterRoute(route)) {
      debugPrint("❌push ${[route.runtimeType, route.settings.name]}");
      return;
    }
    if (_routes.isNotEmpty &&
        _routes.last.settings.name == route.settings.name) {
      return;
    }
    _routes.add(route);
  }

  /// 出栈
  void pop(Route<dynamic> route) {
    _allRoutes.remove(route);
    if (!filterRoute(route)) {
      return;
    }
    _routes.removeWhere((e) => e.settings.name == route.settings.name);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isDebug'] = isDebug;
    data['routes'] = routes.map((e) => e.toString()).toList();
    data['routeNames'] = routeNames;
    data['preRouteName'] = preRouteName;
    data['current'] = current;
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
    onChanged?.call(this);
    if (!isDebug) {
      return;
    }
    developer.log(toString());
  }
}
