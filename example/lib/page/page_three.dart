//
//  PageThree.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 10:04.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'package:example/util/dlog.dart';
import 'package:example/page/page_four.dart';
import 'package:example/view/info_button.dart';
import 'package:flutter/material.dart';
import 'package:route_stack_manager/route_stack_manager.dart';

class PageThree extends StatefulWidget {
  const PageThree({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> with RouteListenterMixin {
  final scrollController = ScrollController();

  @override
  void onRouteBeforeListener({Route? from, Route? to}) {
    DLog.d("$widget onRouteBeforeListener ${[from, to].map((e) => e?.settings.name).join(" >> ")}");
  }

  @override
  void onRouteListener({Route? from, Route? to}) {
    DLog.d("$widget onRouteListener ${[RouteManager().preRouteName, RouteManager().currentRouteName].join(" >>> ")}");
  }

  @override
  void didUpdateWidget(covariant PageThree oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$widget"),
        actions: const [InfoButton()],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton(onPressed: onNext, child: const Text("next")),
          ],
        ),
      ),
    );
  }

  Future<void> onNext() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const PageFour(),
      settings: const RouteSettings(
        name: "/PageFour",
      ),
    ));
    DLog.d("$widget result: $result");
  }
}
