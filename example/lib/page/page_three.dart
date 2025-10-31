//
//  PageThree.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 10:04.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'package:example/view/info_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:route_stack_manager/route_stack_manager.dart';

import '../util/AppNavigator.dart';

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
    DLog.d([from?.settings.name, to?.settings.name].join(" >>> "));
  }

  @override
  void onRouteListener({Route? from, Route? to}) {
    DLog.d([from?.settings.name, to?.settings.name].join(" >>> "));
  }

  @override
  void didUpdateWidget(covariant PageThree oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          title: Text("$widget"),
          actions: const [InfoButton()],
        ),
        body: buildBody(),
      ),
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
            // SizedBox(height: 100),
            // IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back_ios_new)),
            OutlinedButton(onPressed: onNext, child: const Text("next")),
          ],
        ),
      ),
    );
  }

  Future<void> onBack() async {
    final result = AppNavigator.back();
  }

  Future<void> onNext() async {
    final result = await AppNavigator.toNamed(AppRouter.pageFour);
    DLog.d("result: $result");
  }
}
