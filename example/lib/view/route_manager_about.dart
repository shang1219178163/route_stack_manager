//
//  RouteManagerAbout.dart
//  route_stack_manager
//
//  Created by shang on 2025/2/22 11:20.
//  Copyright © 2025/2/22 shang. All rights reserved.
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:route_stack_manager/route_stack_manager.dart';

/// 路由信息打印
class RouteManagerAbout extends StatefulWidget {
  const RouteManagerAbout({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<RouteManagerAbout> createState() => _RouteManagerAboutState();
}

class _RouteManagerAboutState extends State<RouteManagerAbout> {
  final scrollController = ScrollController();

  var content = "";

  @override
  void initState() {
    super.initState();

    final map = RouteManager().toJson();
    const encoder = JsonEncoder.withIndent("  "); // 使用带缩进的 JSON 编码器
    final result = encoder.convert(map);
    content = result;
  }

  @override
  void didUpdateWidget(covariant RouteManagerAbout oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Text(content);
  }
}
