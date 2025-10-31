//
//  PageOne.dart
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

class PageOne extends StatefulWidget {
  const PageOne({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with RouteListenterMixin {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    RouteManager().isDebug = false;

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   onLight();
    // });
  }

  @override
  void onRouteBeforeListener({Route? from, Route? to}) {
    DLog.d([from?.settings.name, to?.settings.name].join(" >>> "));
  }

  @override
  void onRouteListener({Route? from, Route? to}) {
    // DLog.d([from?.settings.name, to?.settings.name].join(" >>> "));

    final fromName = from?.settings.name;
    final toName = to?.settings.name;
    final isLight = fromName == AppRouter.homePage && toName == AppRouter.pageOne;
    final isDark = fromName == AppRouter.pageTwo && toName == AppRouter.pageOne;
    DLog.d([fromName, toName, isLight, isDark].join(" >>> "));

    // if (isLight) {
    //   onDark();
    // }
    //
    // if (isDark) {
    //   onLight();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // 使用 AnnotatedRegion 保底（某些平台或 Flutter 版本需要）
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.green,
        // appBar: AppBar(
        // title: Text("$widget"),
        // actions: const [InfoButton()],
        //     ),
        // ),
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
            SizedBox(height: 100),
            IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back_ios_new)),
            OutlinedButton(onPressed: onNext, child: const Text("next")),
            OutlinedButton(onPressed: onLight, child: const Text("onLight")),
            OutlinedButton(onPressed: onDark, child: const Text("onDark")),
          ],
        ),
      ),
    );
  }

  Future<void> onBack() async {
    final result = AppNavigator.back();
  }

  Future<void> onNext() async {
    final result = await AppNavigator.toNamed(AppRouter.pageTwo);
    DLog.d(result);
  }

  Future<void> onDark() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    DLog.d("onDark");
  }

  Future<void> onLight() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // Future.delayed(Duration(milliseconds: 300), () {
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // });
    DLog.d("onLight");
  }
}
