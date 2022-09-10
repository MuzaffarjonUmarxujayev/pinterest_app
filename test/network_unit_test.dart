
import 'package:flutter_test/flutter_test.dart';
import 'package:pinterest_app/models/collections_model.dart';
import 'package:pinterest_app/models/search_collections.dart';
import 'package:pinterest_app/models/search_model.dart';
import 'package:pinterest_app/models/single_photo_model.dart';
import 'package:pinterest_app/models/topics_model.dart';
import 'package:pinterest_app/models/user_profile.dart';
import 'package:pinterest_app/services/network_service.dart';

void main(){
  
  
  // API_LIST_USERS
  group('Test: Photos from Server', () {
    
    String? response;
    test('test1: check network: element', () async{
      response = await NetworkService.GET(NetworkService.API_LIST_PHOTOS, NetworkService.paramsPhotosList());
      expect(response, isNotNull);
    });

    List<SinglePhotoModel>? singlePhotoList;
    test('test2: check network: model', (){
      singlePhotoList = photoListFromJson(response!);
      expect(singlePhotoList!.isNotEmpty, isTrue);
    });

    
    test('test3: check get list', () async {
     response = await NetworkService.GET(NetworkService.API_LIST_PHOTOS, NetworkService.paramsUsersList());
     expect(response, isNotNull);
    });
  });


  // API_PHOTOS
  group('Test: Connect Photos with Server ', () {
    String? response;

    test('test1: Get a photo', ()async{
      response = await NetworkService.GET('${NetworkService.API_A_PHOTO}7vmICcFrYQ0', NetworkService.paramsEmpty());
      expect(response, isNotNull);
    });



    String? getPhotosList;
    test('test2: get photos list', ()async{
      getPhotosList = await NetworkService.GET(NetworkService.API_LIST_PHOTOS, NetworkService.paramsPhotosList());
       expect(getPhotosList, isNotNull);
    });

    List<SinglePhotoModel> model;
    test('test3: model', (){
      model = photoListFromJson(getPhotosList!);
      expect(model.isNotEmpty, isTrue);
    });

  });

  //API_SEARCH
  group('Test Search photos from Server', () {

    String? getSearchImage;
    test('test1: search images', ()async{
      getSearchImage = await NetworkService.GET(NetworkService.API_SEARCH_PHOTO, NetworkService.paramsSearchPhotos(query: 'sports'));
      expect(getSearchImage, isNotNull);
    });

    List<SearchResultModel>? searchPhoto;
    test('test2: search model', (){
      // searchPhoto = searchListFromJson(getSearchImage!);
      expect(searchPhoto!.isNotEmpty, isTrue);
    });

    String? getSearchCollections;
    test('test2: Search Collections', ()async{
      getSearchCollections = await NetworkService.GET(NetworkService.API_SEARCH_COLLECTIONS_PHOTO, NetworkService.paramsCollections(query: 'flower'));
      expect(getSearchCollections, isNotNull);
    });

    List<SearchCollectionsResultModel>? responseSearchCollections;
    test('test3 search collections model', (){
      responseSearchCollections = searchCollectionListFromJson(getSearchCollections!);
      expect(responseSearchCollections!.isNotEmpty, isTrue);
    });

    // String? searchUser;
    // test('test4: search users', ()async{
    //   searchUser = await NetworkService.GET(NetworkService.API_SEARCH_USERS, NetworkService.paramsCollections(query: 'cars'));
    //   expect(searchUser, isNotNull);
    // });
  });

  //API_COLLECTIONS

  group('Test: Collections', () {

    String? responseCollection;
    test('test1: get collectionsList', ()async{
      responseCollection = await NetworkService.GET(NetworkService.API_COLLECTIONS_LIST, NetworkService.paramsListCollections());
      expect(responseCollection, isNotNull);
    });

    List<Collections> listCollections;
    test('test2: check network: model', (){
      listCollections = collectionsListFromJson(responseCollection!);
      expect(listCollections.isNotEmpty, isTrue);
    });

    String? getACollections;
    test('test2: get a collection', ()async{
      getACollections = await NetworkService.GET('${NetworkService.API_GET_A_COLLECTION}8240069', NetworkService.paramsEmpty());
      expect(getACollections, isNotNull);
    });

  });

  String? getProfile;
  group('Profile', () {
    test('get profile img', ()async{
      getProfile = await NetworkService.GET(NetworkService.API_LIST_USER_PRIFILE + 'Ali', NetworkService.paramsEmpty());
      expect(getProfile, isNotNull);
    });

    List<UserProfile>? profile;
    test('test:2 model', (){
      profile = userProfileListFromJson(getProfile!);
      expect(profile, isNotNull);
    });
  });

  String? topics;
  group('Test: Topic', () {
    test('test1: get topic', ()async{
      topics = await NetworkService.GET(NetworkService.API_TOPICS, NetworkService.paramsTopics(id_or_slug: 'dog'));
      expect(topics, isNotNull);
    });

    List<Topics>? listTopic;
    test('topic parse model', (){
      listTopic = topicListFromJson(topics!);
      expect(listTopic, isNotNull);
    });

  });



}