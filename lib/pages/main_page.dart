import 'package:flutter/material.dart';

import 'main_home_page.dart';

class MainPage extends StatefulWidget {
  static const id = 'main_page';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, boxConstraints) {
          int crossAxisCount = boxConstraints.maxWidth ~/ 250;
          if(boxConstraints.maxWidth < 580) {
           //phone
            return const MainHomePage(crossAxisCount: 2,);
          } if(boxConstraints.maxWidth < 1025) {
            // tablet
            return MainHomePage(crossAxisCount: crossAxisCount,);
          } else {
            // desktop
            return MainHomePage(crossAxisCount: crossAxisCount,);
          }
        }
    );
  }
}

