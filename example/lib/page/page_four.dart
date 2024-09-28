//
//  PageFour.dart
//  route_stack_manager
//
//  Created by shang on 2024/9/28 10:04.
//  Copyright © 2024/9/28 shang. All rights reserved.
//

import 'package:example/page/page_five.dart';
import 'package:flutter/material.dart';

class PageFour extends StatefulWidget {
  const PageFour({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant PageFour oldWidget) {
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
      builder: (context) => PageFive(),
      settings: const RouteSettings(
        name: "/PageFive",
      ),
    ));
  }
}
