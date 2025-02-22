//
//  RouteManagerObserver.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 09:51.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'package:flutter/cupertino.dart';

import 'route_manager.dart';

/// 堆栈管理器路由监听器
class RouteManagerObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouteManager().preRoute = previousRoute;
    RouteManager().notifyRouteBeforeListeners(from: previousRoute, to: route);

    super.didPush(route, previousRoute);
    RouteManager().push(route);

    RouteManager().notifyListeners(from: previousRoute, to: route);
    RouteManager().logRoutes();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouteManager().preRoute = route;
    RouteManager().notifyRouteBeforeListeners(from: route, to: previousRoute);

    super.didPop(route, previousRoute);
    RouteManager().pop(route);

    RouteManager().notifyListeners(from: previousRoute, to: route);
    RouteManager().logRoutes();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    RouteManager().preRoute = oldRoute;
    RouteManager().notifyRouteBeforeListeners(from: oldRoute, to: newRoute);

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) RouteManager().pop(oldRoute);
    if (newRoute != null) RouteManager().push(newRoute);

    RouteManager().notifyListeners(from: oldRoute, to: newRoute);
    RouteManager().logRoutes();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouteManager().preRoute = route;
    RouteManager().notifyRouteBeforeListeners(from: previousRoute, to: route);

    super.didRemove(route, previousRoute);
    RouteManager().pop(route);

    RouteManager().notifyListeners(from: previousRoute, to: route);
    RouteManager().logRoutes();
  }
}
