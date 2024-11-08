//
//  RouteManager.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 09:51.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 路由堆栈管理器
class RouteManager {
  static final RouteManager _instance = RouteManager._();
  RouteManager._();
  factory RouteManager() => _instance;
  static RouteManager get instance => _instance;

  /// 监听列表
  final List<VoidCallback> _listeners = [];

  // 添加监听
  void addListener(VoidCallback cb) {
    if (_listeners.contains(cb)) {
      return;
    }
    _listeners.add(cb);
  }

  // 移除监听
  void removeListener(VoidCallback cb) {
    _listeners.remove(cb);
  }

  // 通知所有监听器
  void notifyListeners() {
    for (var ltr in _listeners) {
      ltr();
    }
  }

  /// 是否打印日志
  bool isDebug = false;

  /// 所有路由堆栈
  final List<Route<dynamic>> _routes = [];

  /// 当前路由堆栈
  List<Route<dynamic>> get routes => _routes;

  /// 当前 PageRoute 路由堆栈
  List<PageRoute<dynamic>> get pageRoutes => _routes.whereType<PageRoute>().toList();

  /// 当前 DialogRoute 路由堆栈
  List<DialogRoute<dynamic>> get dialogRoutes => _routes.whereType<DialogRoute>().toList();

  /// 当前 ModalBottomSheetRoute 路由堆栈
  List<ModalBottomSheetRoute<dynamic>> get sheetRoutes => _routes.whereType<ModalBottomSheetRoute>().toList();

  /// 当前路由名堆栈
  List<String?> get routeNames => routes.map((e) => e.settings.name).toList();

  /// 之前路由
  Route<dynamic>? preRoute;

  /// 之前路由 name
  String? get preRouteName => preRoute?.settings.name;

  /// 当前路由
  Route<dynamic>? get currentRoute => routes.isEmpty ? null : routes.last;

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

  // /// 进出堆栈过滤条件(默认仅支持PageRoute, 过滤弹窗)
  // bool Function(Route<dynamic> route) filterRoute =
  //     (route) => route is PageRoute && route.settings.name != null;

  /// 更新回调
  // ValueChanged<RouteManager>? onChanged;

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
    // onChanged?.call(this);
    notifyListeners();
    if (!isDebug) {
      return;
    }

    developer.log(toString());
  }
}
