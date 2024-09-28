//
//  PageTwo.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 10:04.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'package:example/page/page_three.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant PageTwo oldWidget) {
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
          ],
        ),
      ),
    );
  }

  void onNext() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PageThree(),
      settings: const RouteSettings(
        name: "/PageThree",
      ),
    ));
  }
}
