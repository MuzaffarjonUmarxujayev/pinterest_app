import 'package:flutter/material.dart';
import '../../models/single_photo_model.dart';
import '../../services/network_service.dart';
import '../../viwes/gallary_view.dart';

class HomePhonePage extends StatefulWidget {
  static const id = '/home_page';
  final int crossAxisCount;
  final int subPage;

  const HomePhonePage({Key? key, this.crossAxisCount = 2, this.subPage = 0})
      : super(key: key);

  @override
  State<HomePhonePage> createState() => _HomePhonePageState();
}

class _HomePhonePageState extends State<HomePhonePage> {
  PageController pageController = PageController(keepPage: true);
  int currentPage = 0;
  List<SinglePhotoModel> photoList = [];

  int get limit {
    return widget.crossAxisCount * 15;
  }

  @override
  void initState() {
    currentPage = widget.subPage;
    pageController = PageController(initialPage: widget.subPage, keepPage: true);
    super.initState();
  }




  void _onPageChanged(int page) {
    currentPage = page;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,

          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 23),
                child: Text(
                  'All',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(left: 18),
                height: 5,
                width: 27.5,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)),
              )
            ],
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: _onPageChanged,
          children: [
            GalleryView(
                api: NetworkService.API_LIST_PHOTOS,
                realPage: 0,
                crossAxisCount: widget.crossAxisCount,
                params: NetworkService.paramsPhotosList(perPage: limit)),
          ],
        ),
    );
  }
}
