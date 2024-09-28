//
//  PageOne.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 10:04.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'package:example/page/page_two.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final _scrollController = ScrollController();

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
      builder: (context) => PageTwo(),
      settings: const RouteSettings(
        name: "/PageTwo",
      ),
    ));
  }
}
