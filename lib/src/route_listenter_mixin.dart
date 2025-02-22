//
//  RouteListenterMixin.dart
//  route_stack_manager
//
//  Created by shang on 2024/11/8 17:52.
//  Copyright © 2024/11/8 shang. All rights reserved.
//

import 'package:flutter/material.dart';
import '../route_stack_manager.dart';

/// 路由监听 mixin
mixin RouteListenterMixin<T extends StatefulWidget> on State<T> {
  @override
  void dispose() {
    RouteManager().removeRouteBeforeListener(onRouteBeforeListener);
    RouteManager().removeListener(onRouteListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    RouteManager().addRouteBeforeListener(onRouteBeforeListener);
    RouteManager().addListener(onRouteListener);
  }

  void onRouteListener({Route? from, Route? to}) {
    // DLog.d("$widget initState ${[RouteManager().preRouteName, RouteManager().currentRouteName]}");
    throw UnimplementedError("❌$this Not implemented onRouteListener");
  }

  void onRouteBeforeListener({Route? from, Route? to}) {
    // DLog.d("$widget initState ${[RouteManager().preRouteName, RouteManager().currentRouteName]}");
    throw UnimplementedError("❌$this Not implemented onRouteBeforeListener");
  }
}
