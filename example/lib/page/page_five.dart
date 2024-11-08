//
//  PageFive.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 10:04.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

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
            OutlinedButton(onPressed: showDialog, child: const Text("showDialog")),
            OutlinedButton(onPressed: showSheet, child: const Text("showSheet")),
          ],
        ),
      ),
    );
  }

  void onNext() {
    DLog.d(RouteManager().toString());
  }

  void onDelete() {
    Navigator.of(context).removeRoute(RouteManager().routes.last);
  }

  void showDialog() async {
    final result = await showCupertinoDialog(
      context: context,
      builder: (context) {
        return Container(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              constraints: const BoxConstraints(
                minWidth: 300,
                maxWidth: 300,
                minHeight: 200,
                maxHeight: 400,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      RouteManager().popupRoute?.navigator?.pop({"result99": "resultABC"});
                    },
                    child: const Text("showSheet"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    DLog.d(RouteManager().toString());
    DLog.d("result: $result");
  }

  Future<void> showSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          color: Colors.yellow,
        );
      },
    );
    DLog.d(RouteManager().toString());
  }
}
