import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import '../models/single_photo_model.dart' as model;
import '../models/user_model.dart';
import '../pages/mobile/detail_page.dart';
import '../services/network_service.dart';

class PhotoView extends StatefulWidget {
  final int crossAxisCount;
  final model.SinglePhotoModel photos;
  int currentIndex;

   PhotoView({Key? key, this.crossAxisCount = 2, required this.photos, required this.currentIndex})
      : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late model.SinglePhotoModel photos;
  late User user;
  double ratio = 16 / 9;
  bool visible = false;
  bool isLiked = false;
  String? favoriteId;
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    _convertData();
  }

  Future<void> get checkInternet async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    setState(() {});
  }

  void _convertData() {
    photos = widget.photos;
    if (photos.width != null && photos.height != null) {
      ratio = photos.width! / photos.height!;
    }
    setState(() {});
  }

  void _shareImage() async {
    final urlShare = photos.urls!.small!;

    await Share.share('Share to Image $urlShare');
  }

  void _favorite() async {
    setState(() {
      isLiked = !isLiked;
      visible = true;
    });

    if (isLiked) {
      String? responseFavorite = await NetworkService.POST(
          '${NetworkService.API_MY_LIKE}${photos.id.toString()}/like',
          NetworkService.paramsEmpty(),
          NetworkService.bodyFavourite(photos.id.toString()));
      if (responseFavorite != null) {
        favoriteId = jsonDecode(responseFavorite)["id"].toString();
        setState(() {});
      }

      if (!isLiked) {
        String? responseFavorite = await NetworkService.DELETE(
            '${NetworkService.API_MY_LIKE}${photos.id.toString()}/like',
            NetworkService.paramsEmpty());
        debugPrint(responseFavorite);
      }
    }
  }

  void openDetailPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => DetailPage(
                photo: photos,
                crossAxisCount: widget.crossAxisCount,
                currentIndex: widget.currentIndex,


              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onDoubleTap: _favorite,
          onTap: openDetailPage,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: ratio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: photos.urls!.small!,
                    placeholder: (context, url) => Container(
                      color: Colors.primaries[Random().nextInt(18) % 18],
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  if (!isLiked && visible)
                    Center(
                        child: Lottie.asset(
                            "assets/lottie/lottie_broken_heart.json",
                            repeat: false, onLoaded: (lottieComposition) {
                      Future.delayed(
                        lottieComposition.duration,
                        () {
                          setState(() {
                            visible = false;
                          });
                        },
                      );
                    })),
                  if (isLiked && visible)
                    Center(
                        child: Lottie.asset("assets/lottie/lottie_heart.json",
                            repeat: false, onLoaded: (lottieComposition) {
                      Future.delayed(
                        lottieComposition.duration,
                        () {
                          setState(() {
                            visible = false;
                          });
                        },
                      );
                    })),
                ],
              ),
            ),
          ),
        ),
        //# photoData
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(bottom: 10, top: 5, left: 5),
          title: photos.user != null && photos.user!.username!.isNotEmpty
              ? Text(
                  photos.user!.firstName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                )
              : null,
          subtitle:
              photos.likes != null
                  ? Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red,size: 20,),
                      const SizedBox(width: 10,),
                      Text('${photos.likes!}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white)),
                    ],
                  )
                  : null,
          trailing: IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: IconButton(
                onPressed: _shareImage,
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.white,
                )),
          ),
        )
      ],
    );
  }
}
