import 'package:example/page/page_one.dart';
import 'package:example/util/dlog.dart';
import 'package:example/view/info_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:route_stack_manager/route_stack_manager.dart';

void main() {
  RouteManager().isDebug = kDebugMode;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [
        RouteManagerObserver(),
      ],
      theme: buildTheme(),
      home: const MyHomePage(title: 'Home Page'),
    );
  }

  ThemeData? buildTheme() {
    const primary = Colors.blue;
    return ThemeData(
      primarySwatch: primary,
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          side: MaterialStateProperty.all(const BorderSide(color: primary, width: 1)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateProperty.all(primary),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          children: <Widget>[
            OutlinedButton(onPressed: onNext, child: const Text("next")),
          ],
        ),
      ),
    );
  }

  Future<void> onNext() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PageOne(),
        settings: const RouteSettings(
          name: "/PageOne",
        ),
      ),
    );
    DLog.d("$widget result: $result");
  }
}
