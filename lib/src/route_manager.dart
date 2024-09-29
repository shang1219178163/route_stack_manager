//
//  RouteManager.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 09:51.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

/// 路由堆栈管理器
class RouteManager {
  static final RouteManager _instance = RouteManager._();
  RouteManager._();
  factory RouteManager() => _instance;
  static RouteManager get instance => _instance;

  /// 是都打印日志
  bool isDebug = false;

  /// 路由堆栈
  final List<Route<dynamic>> _routes = [];

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

  /// 当前路由类型是 PopupRoute
  bool get isPopupOpen => currentRoute is PopupRoute;

  /// 当前路由类型是 DialogRoute
  bool get isDialogOpen => currentRoute is DialogRoute;

  /// 当前路由类型是 ModalBottomSheetRoute
  bool get isSheetOpen => currentRoute is ModalBottomSheetRoute;

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
