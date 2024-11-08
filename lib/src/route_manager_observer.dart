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
    super.didPush(route, previousRoute);
    RouteManager().push(route);
    RouteManager().preRoute = previousRoute;
    RouteManager().logRoutes();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    RouteManager().pop(route);
    RouteManager().preRoute = route;
    RouteManager().logRoutes();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null && newRoute != null) {
      RouteManager().pop(oldRoute);
      RouteManager().push(newRoute);
      RouteManager().preRoute = oldRoute;
      RouteManager().logRoutes();
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    RouteManager().pop(route);
    RouteManager().preRoute = route;
    RouteManager().logRoutes();
  }
}
