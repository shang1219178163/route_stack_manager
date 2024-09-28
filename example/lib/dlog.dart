//
//  DLog.dart
//
//
//  Created by shang on 2023/10/16 09:40.
//  Copyright © 2023/10/16 shang. All rights reserved.
//

import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class DLog {
  /// 防止日志被截断
  static void d(dynamic text) {
    if (!kDebugMode) {
      return;
    }
    developer.log("DLog ${DateTime.now()} $text");
  }
}
