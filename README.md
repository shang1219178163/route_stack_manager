# route_stack_manager

flutter 路由堆栈监听.
flutter Route stack listeners.


## 1、Use：

```dart
  navigatorObservers: [
    RouteManagerObserver(),
  ],
```

## 2、Log：

in PageFive:

```dart
class _PageFiveState extends State<PageFive> with RouteListenterMixin {

  @override
  void onRouteBeforeListener({Route? from, Route? to}) {
    DLog.d([from, to]
        .map((e) => e?.settings.name)
        .join(" >> "));
  }

  @override
  void onRouteListener({Route? from, Route? to}) {
    DLog.d([
      RouteManager().preRouteName,
      RouteManager().currentRouteName
    ].join(" >>> "));
  }
  
  @override
  Widget build(BuildContext context) {
    //...
  }

  void onNext() {
    DLog.d(RouteManager().toString());
  }
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
    
  
  ## 3、RouteManager API
    
    class RouteManager {
      static final RouteManager _instance = RouteManager._();
      RouteManager._();
      factory RouteManager() => _instance;
      static RouteManager get instance => _instance;
    
      bool isDebug = false;
    
      void addListener(void Function({Route? from, Route? to}) cb);
    
      void removeListener(void Function({Route? from, Route? to}) cb);
    

      /// all Route
      List<Route<Object?>> get routes;
    
      List<PageRoute<Object?>> get pageRoutes;
    
      List<RawDialogRoute<Object?>> get dialogRoutes;
    
      List<ModalBottomSheetRoute<Object?>> get sheetRoutes;
    
      List<String?> get routeNames;
    
      Route<Object?>? get preRoute;
    
      String? get preRouteName;
    
      Route<Object?>? get currentRoute;
    
      String? get currentRouteName;
    
      PopupRoute? get popupRoute;
    
      bool get isPopupOpen;
    
      bool get isDialogOpen;
    
      bool get isSheetOpen;
    
      bool contain(String routeName);
    
      Object? getArguments(String routeName);
    
      ......  
    }