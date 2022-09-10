import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_app/viwes/user_image_view.dart';
import '../models/single_photo_model.dart';
import '../services/network_service.dart';

class GalleryView extends StatefulWidget {
  final int crossAxisCount;
  final String api;
  final int realPage;
  final Map<String, String> params;
  final ScrollPhysics? physics;

  const GalleryView(
      {Key? key,
      this.physics,
      this.crossAxisCount = 2,
      required this.api,
        required this.realPage,
      required this.params})
      : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView>
    with AutomaticKeepAliveClientMixin {
  List<SinglePhotoModel> photos = [];
  ScrollController controller = ScrollController();
  Map<String, String> params = {};
  int currentPage = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    params = widget.params;
    apiGetAllPhotos(currentPage++);
    controller.addListener(loadMore);
  }

  void apiGetAllPhotos(int page) async {
    params['page'] = page.toString();
    String? addAllPhotos = await NetworkService.GET(widget.api, params);
    photos.addAll(photoListFromJson(addAllPhotos!));
    setState(() {});
  }

  void loadMore() async {
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      apiGetAllPhotos(currentPage++);
    }
  }

  Future<void> onRefresh() async {
    photos = [];
    // currentPage = 0;
    if (Platform.isAndroid) {
      setState(() {
        apiGetAllPhotos(currentPage +=2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: onRefresh,
        child: MasonryGridView.count(
          physics: widget.physics,
          shrinkWrap: true,
          controller: controller,
          crossAxisCount: widget.crossAxisCount,
          itemCount: photos.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return PhotoView(
              photos: photos[index],
              currentIndex: currentPage,
              crossAxisCount: widget.crossAxisCount,

            );
          },
        ));
  }
}
