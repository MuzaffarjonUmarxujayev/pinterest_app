import 'package:flutter/material.dart';
import '../viwes/updates_view.dart';
import '../viwes/inbox_view.dart';


class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  int selectedScreen = 0;
  final PageController _pageController = PageController(keepPage: true);

  void _onPressedScreen(int screen) {
    selectedScreen = screen;
    _pageController.jumpToPage(screen);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // #favorite
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: selectedScreen == 0 ? Colors.white : Colors.black,
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
              ),
              onPressed: () => _onPressedScreen(0),
              child: Text("Updates", style: TextStyle(color: selectedScreen == 0
                  ? Colors.black
                  : Colors.white, fontSize: 16),),
            ),
            const SizedBox(width: 10,),

            // #vote
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: selectedScreen == 1 ? Colors.white : Colors.black,
                  elevation: 0,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
              ),
              onPressed: () => _onPressedScreen(1),
              child: Text("  Inbox  ", style: TextStyle(color: selectedScreen == 1
                  ? Colors.black
                  : Colors.white, fontSize: 16),),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          selectedScreen = page;
          setState(() {});
        },
        children: const [
          UpdatesView(),
          InboxView(),
        ],
      ),
    );
  }
}
