import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart'hide Image;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/collections_model.dart';
import '../services/network_service.dart';

class UpdatesView extends StatefulWidget {
  const UpdatesView({Key? key}) : super(key: key);

  @override
  State<UpdatesView> createState() => _UpdatesViewState();
}

class _UpdatesViewState extends State<UpdatesView> {

  int page = 0;
  List<Collections> items = [];

  ScrollController controller = ScrollController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _apiGetAllImage(currentPage++);
    controller.addListener(loadMore);
  }

  void _apiGetAllImage(int page)async{
    String? response =  await NetworkService.GET(NetworkService.API_COLLECTIONS_LIST, NetworkService.paramsListCollections(page: page, perPage: 20)) ?? '[]';
    items.addAll(collectionsListFromJson(response));
    setState(() {});
  }

  void loadMore()async {
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      _apiGetAllImage(currentPage++);

    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          const QuiltedGridTile(1, 2),
          const QuiltedGridTile(1, 2),
          const QuiltedGridTile(1, 2),
          const QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
              (context, index) => Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: items[index].coverPhoto!.urls!.small!,
                placeholder: (context, url) => Container(
                  color: Colors.primaries[Random().nextInt(18) % 18],
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Center(child: items.first.title != null ? Text(items.first.title!, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),) : const Text('')),
            ],
          ),
          childCount: items.length
      ),
    );
  }
}

