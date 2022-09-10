import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/single_photo_model.dart' as model;
import '../../models/single_photo_model.dart';
import '../../services/network_service.dart';
import '../../viwes/gallary_view.dart';


class DetailPage extends StatefulWidget {
  static const id = 'detail_page';

  final int crossAxisCount;
  int currentIndex;
  final model.SinglePhotoModel photo;
   DetailPage({Key? key, required this.photo, this.crossAxisCount = 2, required this.currentIndex,}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with AutomaticKeepAliveClientMixin{
   late model.SinglePhotoModel photo;
   List<SinglePhotoModel> getPhotoList = [];
   // List<UserProfile> getPhoto = [];
   double ratio = 16 / 9;
   String title = "";
   String subTitle = "";
   int currentPage = 0;
   bool visible = false;
   bool isLiked = false;
   String? favoriteId;

   @override
  void initState()  {
    super.initState();
    _convertData();
    _getImageImg();
  }

   int get limit {
     return widget.crossAxisCount * 15;
   }

   @override
   bool get wantKeepAlive => true;

   void _convertData(){
     photo = widget.photo;
     if(photo.width != null && photo.height != null){
       ratio = photo.width! / photo.height!;
     }
     setState(() {});
   }


   void _getImageImg() async{
     String? response = await NetworkService.GET(NetworkService.API_LIST_PHOTOS, NetworkService.paramsPhotosList());
     getPhotoList.addAll(photoListFromJson(response!));
     setState(() {});
   }

   void _favorite() async{
     setState(() {
       isLiked = !isLiked;
       visible = true;
     });

     if(isLiked){
       String? responseFavorite = await NetworkService.POST('${NetworkService.API_MY_LIKE}${photo.id.toString()}/like', NetworkService.paramsEmpty(), NetworkService.bodyFavourite(photo.id.toString()));
       if(responseFavorite != null) {
         favoriteId = jsonDecode(responseFavorite)["id"].toString();
         setState(() {});
       }

       if(!isLiked) {
         String? responseFavorite = await NetworkService.DELETE('${NetworkService.API_MY_LIKE}${photo.id.toString()}/like', NetworkService.paramsEmpty());
         debugPrint(responseFavorite);
       }
     }
   }

   void _shareImage()async{
     final urlShare = photo.urls!.small!;
     await Share.share('Share to Image $urlShare');
   }

   // downland image
  Future<void> _saveImage() async {
     try {
       var imageId = await ImageDownloader.downloadImage(photo.urls!.small!,
       destination: AndroidDestinationType.directoryDownloads..subDirectory('PinterestApp/flutter_image.png')
       );
       print('Image Downland Successfully');
       if (imageId == null) {
         return;
       }
     } on PlatformException catch (error) {
       print(error);
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){},
              icon: const Icon(Icons.more_horiz_outlined, size: 30,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //#image
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white.withOpacity(0.6),
                    Colors.white.withOpacity(0.2),
                    Colors.black.withOpacity(0.1),
                  ]
                )
              ),
              child: AspectRatio(
                aspectRatio: ratio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: photo.urls!.small!,
                      placeholder: (context, url) => Container(
                        color: Colors.primaries[Random().nextInt(18) % 18],
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),

                    if(!isLiked && visible)
                      Center(
                          child: Lottie.asset(
                              "assets/lottie/lottie_broken_heart.json",
                              repeat: false,
                              onLoaded: (lottieComposition) {
                                Future.delayed(
                                  lottieComposition.duration,
                                      () {
                                    setState(() {
                                      visible = false;
                                    });
                                  },);
                              }
                          )
                      ),

                    if(isLiked && visible)
                      Center(
                          child: Lottie.asset(
                              "assets/lottie/lottie_heart.json",
                              repeat: false,
                              onLoaded: (lottieComposition) {
                                Future.delayed(
                                  lottieComposition.duration,
                                      () {
                                    setState(() {
                                      visible = false;
                                    },
                                    );
                                  },
                                );
                              }
                          ),
                      ),
                  ],
                ),
              ),
            ),

           //#footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //profileImg
                  ListTile(
                    leading: Container(
                      height: 45,
                      width: 45,
                      decoration:   BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                        border: Border.all(color: Colors.white),
                        image: const DecorationImage(
                          image:  AssetImage('assets/images/profile-placeholder.png'),
                           fit: BoxFit.cover
                        )
                      ),

                      ),
                    // title:  Text('${getPhotoList}'),
                    subtitle:  Text(photo.user!.name!, style: TextStyle(color: Colors.white),),
                  ),


                  const SizedBox(height: 10,),

                  // #subtitle
                  Visibility(
                    visible: subTitle.isNotEmpty,
                    child: Text(subTitle, style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  const SizedBox(height: 10,),

                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox.shrink(),
                      ),

                      // #favorite
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _favorite,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: !isLiked ? const Color.fromRGBO(239, 239, 239, 1) : Colors.red,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          ),
                          child: const Text("Favorite", style: TextStyle(color: Colors.black, fontSize: 17.5, fontWeight: FontWeight.w600),),
                        ),
                      ),
                      const SizedBox(width: 15,),

                      // #save
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _saveImage,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.red,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          ),
                          child: const Text("Save", style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w600),),
                        ),
                      ),

                      // #share
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.share, size: 30,),
                          onPressed: _shareImage,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,)
                ],
              ),
            ),
            const SizedBox(height: 1,),
            //#simliary
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(40), right: Radius.circular(40)),
                color: Colors.white,
              ),
              child:  LayoutBuilder(
                builder: (context, boxConstraints) {
                  int crossAxisCount = boxConstraints.maxWidth ~/ 250;
                  if(boxConstraints.maxWidth < 580){
                    //phone
                    return GalleryView(api: NetworkService.API_LIST_PHOTOS, crossAxisCount: 2, realPage: currentPage,params:  NetworkService.paramsPhotosList(perPage: limit),
                        physics: const NeverScrollableScrollPhysics());
                  }
                  if(boxConstraints.maxWidth < 1025){
                   return GalleryView(api: NetworkService.API_LIST_PHOTOS, crossAxisCount: crossAxisCount,realPage: currentPage, params:  NetworkService.paramsPhotosList(perPage: limit),
                    physics: const NeverScrollableScrollPhysics());
                    } else{
                 return GalleryView(api: NetworkService.API_LIST_PHOTOS, crossAxisCount: crossAxisCount, realPage: currentPage, params:  NetworkService.paramsPhotosList(perPage: limit),
                  physics: const NeverScrollableScrollPhysics());
                   }


                }

              ),
            )
          ],
        ),
      ),
    );
  }


}
