import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/search_model.dart';
import '../services/network_service.dart';

class SearchPage extends StatefulWidget {

  final int crossAxisCount;

  const SearchPage({Key? key, this.crossAxisCount = 2,}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController controller = ScrollController();

  int selectedScreen = 0;

  List<Results> responseSearch = [];
  List<Results> topicSearch = [];

  int _page = 0;
  String searchElement = '';
  String topics = '';
  TextEditingController textController = TextEditingController();
  bool isl = false;

  @override
  void initState() {
    super.initState();
    _apiSearchGetPhoto(searchElement, _page++);
    controller.addListener(_loadMore);
  }

  void _apiSearchGetPhoto(String? searchElement, int page) async {
    searchElement = textController.text.trim();

    String? getSearchPhotos = await NetworkService.GET(NetworkService.API_SEARCH_PHOTO, NetworkService.paramsSearchPhotos(query: searchElement, perPage: 40, page: page));
    responseSearch.addAll(searchFromJson(getSearchPhotos!).results!);
    setState(() {});
  }


  void _loadMore() {
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      _apiSearchGetPhoto(searchElement, _page++);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: '  Search',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    onSubmitted: (String search) {
                      _apiSearchGetPhoto(search, _page++);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, boxConstraints) {
          int crossAxisCount = boxConstraints.maxWidth ~/ 250;
          if(boxConstraints.maxWidth < 580){
            return MasonryGridView.count(
              shrinkWrap: true,
              controller: controller,
              crossAxisCount: 2,
              itemCount: responseSearch.length,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CachedNetworkImage(
                    imageUrl: responseSearch[index].urls!.regular!,
                    placeholder: (context, url) => Container(
                      color: Colors.primaries[Random().nextInt(18) % 18],
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                );
              },
            );
          }
          if(boxConstraints.maxWidth < 1025){
            return MasonryGridView.count(
              shrinkWrap: true,
              controller: controller,
              crossAxisCount: crossAxisCount,
              itemCount: responseSearch.length,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CachedNetworkImage(
                    imageUrl: textController.text.isNotEmpty ? responseSearch[index].urls!.regular! : topicSearch[index].urls!.regular!,
                    placeholder: (context, url) => Container(
                      color: Colors.primaries[Random().nextInt(18) % 18],
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                );
              },
            );
          }else{
            return MasonryGridView.count(
              shrinkWrap: true,
              controller: controller,
              crossAxisCount: crossAxisCount,
              itemCount: responseSearch.length,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CachedNetworkImage(
                    imageUrl: textController.text.isNotEmpty ? responseSearch[index].urls!.regular! : topicSearch[index].urls!.regular!,
                    placeholder: (context, url) => Container(
                      color: Colors.primaries[Random().nextInt(18) % 18],
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                );
              },
            );
          }

        }
      ),
    );
  }
}
