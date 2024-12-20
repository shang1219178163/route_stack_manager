//
//  PageFive.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 10:04.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_stack_manager/route_stack_manager.dart';

import '../util/dlog.dart';

class PageFive extends StatefulWidget {
  const PageFive({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> with RouteListenterMixin {
  final _scrollController = ScrollController();

  @override
  void onRouteListener() {
    DLog.d("$widget initState ${[RouteManager().preRouteName, RouteManager().currentRouteName].join(" >>> ")}");
  }

  @override
  void didUpdateWidget(covariant PageFive oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$widget"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            OutlinedButton(onPressed: onNext, child: const Text("next")),
            OutlinedButton(onPressed: onDelete, child: const Text("onDelete")),
            OutlinedButton(onPressed: onShowDialog, child: const Text("showDialog")),
            OutlinedButton(onPressed: onShowSheet, child: const Text("showSheet")),
          ],
        ),
      ),
    );
  }

  void onNext() {
    DLog.d(RouteManager().toString());
  }

  void onDelete() {
    final route = RouteManager().routes[1];
    Navigator.of(context).removeRoute(route);
  }

  Future<void> onShowDialog() async {
    final result = await showCupertinoDialog(
      context: context,
      routeSettings: const RouteSettings(name: "onShowDialog", arguments: {"a": "a"}),
      builder: (context) {
        return buildAlertContent(
          onCancel: () {
            RouteManager().popupRoute?.navigator?.pop({"ok": false});
          },
          onConfirm: () {
            RouteManager().popupRoute?.navigator?.pop({"ok": true});
          },
        );
      },
    );
    // DLog.d(RouteManager().toString());
    DLog.d("result: $result");
    final isConfirm = result is Bool && result == true || result is Map && result["ok"] == true;
    if (!isConfirm) {
      return;
    }
    RouteManager().pageRoutes.lastOrNull?.navigator?.pop({"aa": "aa"});
    RouteManager().pageRoutes.lastOrNull?.navigator?.pop({"bb": "bb"});
  }

  Future<void> onShowSheet() async {
    showModalBottomSheet(
      context: context,
      routeSettings: const RouteSettings(name: "onShowSheet", arguments: {"b": "b"}),
      builder: (context) {
        return buildAlertContent(
          onCancel: () {
            RouteManager().popupRoute?.navigator?.pop({"ok": false});
          },
          onConfirm: () async {
            await onShowDialog();
            DLog.d([
              RouteManager().popupRoute,
              RouteManager().popupRoute?.settings,
            ].asMap());
          },
        );
        return Container(
          height: 500,
          color: Colors.green,
        );
      },
    );
    DLog.d(RouteManager().toString());
  }

  Widget buildAlertContent({
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) {
    return Align(
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          constraints: const BoxConstraints(
            minWidth: 300,
            maxWidth: 300,
            minHeight: 160,
            maxHeight: 400,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Title",
                style: TextStyle(fontSize: 16),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "这是一条提示信息的详情内容显示;" * 3,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: onCancel,
                      child: const Text("cancel"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      child: const Text("confirm"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
