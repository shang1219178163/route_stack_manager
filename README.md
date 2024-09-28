# route_stack_manager

flutter 路由堆栈监听.
flutter Route stack listeners.


## 1、example：

```dart
  navigatorObservers: [
    RouteManagerObserver(),
  ],
```

## 2、log：

in PageFive:

```dart
  void onNext() {
    DLog.d(RouteManager().toString());
  }
```

    [log] DLog 2024-09-28 10:46:16.173479 RouteManager: {
      "isDebug": true,
      "routes": [
        "MaterialPageRoute<dynamic>(RouteSettings(\"/\", null), animation: AnimationController#38614(⏭ 1.000; paused; for MaterialPageRoute<dynamic>(/)))",
        "MaterialPageRoute<dynamic>(RouteSettings(\"/PageOne\", null), animation: AnimationController#bd787(⏭ 1.000; paused; for MaterialPageRoute<dynamic>(/PageOne)))",
        "MaterialPageRoute<dynamic>(RouteSettings(\"/PageTwo\", null), animation: AnimationController#e1844(⏭ 1.000; paused; for MaterialPageRoute<dynamic>(/PageTwo)))",
        "MaterialPageRoute<dynamic>(RouteSettings(\"/PageThree\", null), animation: AnimationController#4492e(⏭ 1.000; paused; for MaterialPageRoute<dynamic>(/PageThree)))",
        "MaterialPageRoute<dynamic>(RouteSettings(\"/PageFour\", null), animation: AnimationController#a9e6b(⏭ 1.000; paused; for MaterialPageRoute<dynamic>(/PageFour)))",
        "MaterialPageRoute<dynamic>(RouteSettings(\"/PageFive\", null), animation: AnimationController#911b9(⏭ 1.000; paused; for MaterialPageRoute<dynamic>(/PageFive)))"
      ],
      "routeNames": [
        "/",
        "/PageOne",
        "/PageTwo",
        "/PageThree",
        "/PageFour",
        "/PageFive"
      ],
      "preRouteName": "/PageFour",
      "current": "/PageFive"
    }