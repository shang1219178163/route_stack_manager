//
//  PageUnknow.dart
//  route_stack_manager
//
//  Created by shang on 2025/2/22 10:43.
//  Copyright © 2025/2/22 shang. All rights reserved.
//

import 'package:example/view/info_button.dart';
import 'package:flutter/material.dart';

class PageUnknow extends StatefulWidget {
  const PageUnknow({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<PageUnknow> createState() => _PageUnknowState();
}

class _PageUnknowState extends State<PageUnknow> {
  final scrollController = ScrollController();

  /// 数组
  late final items = [
    (title: "onPopRoot", event: onPopRoot, desc: "下一页"),
  ];

  @override
  void didUpdateWidget(covariant PageUnknow oldWidget) {
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
            Wrap(
              spacing: 8,
              children: [
                ...items.map((e) {
                  return OutlinedButton(onPressed: e.event, child: Text(e.title));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onPopRoot() {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }
}
