//
//  InfoButton.dart
//  route_stack_manager
//
//  Created by shang on 2025/2/22 11:39.
//  Copyright © 2025/2/22 shang. All rights reserved.
//

import 'package:example/view/route_manager_about.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 信息按钮
class InfoButton extends StatefulWidget {
  const InfoButton({
    super.key,
  });

  @override
  State<InfoButton> createState() => _InfoButtonState();
}

class _InfoButtonState extends State<InfoButton> {
  @override
  void didUpdateWidget(covariant InfoButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onShowSheet,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: const Icon(
          Icons.error_outline,
          // size: 24,
        ),
      ),
    );
  }

  Future<void> onShowSheet() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      routeSettings: RouteSettings(name: "$widget - showModalBottomSheet", arguments: const {"b": "b"}),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Column(
            children: [
              buildToolBar(title: "路由信息"),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: const Column(
                        children: [
                          RouteManagerAbout(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildToolBar({required String title, VoidCallback? onConfirm, VoidCallback? onCancel}) {
    return SizedBox(
      height: 50,
      child: NavigationToolbar(
        leading: CupertinoButton(
          padding: const EdgeInsets.all(12),
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop();
          },
          child: const Text(
            "取消",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
        middle: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            backgroundColor: Colors.white,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(12),
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop();
          },
          child: const Text(
            "确定",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
