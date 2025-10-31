import 'package:example/util/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:route_stack_manager/route_stack_manager.dart';

import 'dlog.dart';

/// 路由监听 mixin
mixin CurrentOverlayStyleMixin<T extends StatefulWidget> on State<T> {
  @protected
  SystemUiOverlayStyle get currentOverlayStyle;

  @protected
  SystemUiOverlayStyle get otherOverlayStyle;

  @protected
  bool needOverlayStyleChanged({Route? from, Route? to}) {
    throw UnimplementedError("❌$this Not implemented needOverlayStyleChanged");
  }

  @override
  void dispose() {
    RouteManager().removeListener(_onRouteListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    RouteManager().addListener(_onRouteListener);
  }

  void _onRouteListener({Route? from, Route? to}) {
    final fromName = from?.settings.name;
    final toName = to?.settings.name;
    // DLog.d([fromName, toName].join(" >>> "));
    final needChange = needOverlayStyleChanged(from: from, to: to);
    // DLog.d([fromName, toName, needChange].join(" >>> "));
    if (needChange) {
      _onChange(style: currentOverlayStyle); //需要延迟,等UI走完,防止效果被覆盖
    } else {
      _onChange(style: otherOverlayStyle, duration: Duration.zero);
    }
  }

  Future<void> _onChange({
    Duration duration = const Duration(milliseconds: 300),
    required SystemUiOverlayStyle style,
  }) async {
    if (duration == Duration.zero) {
      SystemChrome.setSystemUIOverlayStyle(style);
    } else {
      Future.delayed(duration, () {
        SystemChrome.setSystemUIOverlayStyle(style);
      });
    }
    DLog.d("$this _onChange ${style.statusBarBrightness?.name}");
  }

  /// 电池栏状态修改(push 到新页面回调)
  void currentOverlayStyleRoutePush() {
    Route? from = RouteManager().pageRoutes[RouteManager().pageRoutes.length - 2];
    Route? to = RouteManager().pageRoutes.last;
    _onRouteListener(from: from, to: to);
  }
}
