import 'package:flutter/material.dart';
import 'package:pinterest_app/pages/main_page.dart';

class MyPinterestApp extends StatelessWidget {
  const MyPinterestApp({Key? key}) : super(key: key);
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      home: const MainPage(), //MainPage(),
      routes: {
        MainPage.id: (context) => const MainPage(),
      },
    );
  }
}
