import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'interseptor_services.dart';
import 'log_services.dart';

class NetworkService {
  // baseUrl
  static const isTester = true;

  static const DEVELOPMENT_SERVER = 'api.unsplash.com';
  static const DEPLOYMENT_SERVER = 'api.unsplash.com';

  static String get BASEURL {
    if (isTester) {
      return DEVELOPMENT_SERVER;
    } else {
      return DEPLOYMENT_SERVER;
    }
  }

  // apis
  static const API_LIST_PHOTOS = '/photos';
  static const API_LIST_USER_PRIFILE = '/users/'; //usurname
  static const API_A_PHOTO = '/photos/'; // {ID}
  static const API_SEARCH_PHOTO = '/search/photos';
  static const API_SEARCH_COLLECTIONS_PHOTO = '/search/collections';
  static const API_SEARCH_USERS = '/search/users';
  static const API_COLLECTIONS_LIST = '/collections';
  static const API_GET_A_COLLECTION = '/collections/'; //{ID};
  static const API_MY_LIKE = "/photos/"; //{ID}
  static const API_MY_UNLIKE = "/photos/"; // {ID}
  static const API_TOPICS = "/topics/"; // {ID}{/photos}
  // headers
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Client-ID YGB2Mm66_3VXM9-kpsa7LkhX9Mr8uJk3vahsiIvtIhs'
  };

  static Map<String, String> headersForUpload = {
    'Authorization': 'Client-ID YGB2Mm66_3VXM9-kpsa7LkhX9Mr8uJk3vahsiIvtIhs'
  };

  // interceptor
  static final http = InterceptedHttp.build(interceptors: [
    InterceptorService(),
  ]);

  //methods
  static Future<String?> GET(String api, Map<String, String> params) async {
    Uri url = Uri.https(BASEURL, api, params);
    print("111111111111111111111111111111111111111111111" + url.toString());
    final response = await http.get(url, headers: headers);
    print("111111111111111111111111111111111111111111111: $response");

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('body:0000000000000000000000000000000000000000000000000000000000000000${response.body}');
      return response.body;
    }
    return null;
  }

  // POST

  static Future<String?> POST(String api, Map<String, String> params,
      Map<String, dynamic> body) async {
    Uri url = Uri.https(BASEURL, api);
    final response = await http.post(
        url, headers: headers, body: jsonEncode(body), params: params);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params,
      Map<String, dynamic> body) async {
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.put(
        url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params,
      Map<String, dynamic> body) async {
    Uri url = Uri.https(BASEURL, api);
    final response = await http.patch(
        url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    Uri url = Uri.https(BASEURL, api, params);
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> MULTIPART(String api, String filePath,
      Map<String, String> body) async {
    var uri = Uri.https(BASEURL, api);
    var request = MultipartRequest('POST', uri);
    request.headers.addAll((headersForUpload));
    // request.files.add(await MultipartFile.fromPath('file', filePath, contentType: MediaType('image', 'jpeg')));
    request.fields.addAll(body);
    StreamedResponse response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      LogService.o(response.reasonPhrase.toString());
      LogService.o(response.statusCode.toString());
      return await response.stream.bytesToString();
    } else {
      LogService.e(response.reasonPhrase.toString());
      return response.reasonPhrase;
    }
  }

  /// params

  static Map<String, String> paramsEmpty() {
    Map<String, String> map = {};
    return map;
  }

  // usersParam
  static Map<String, String> paramsUsersList(
      {String? username, int? page = 1, int? perPage = 10, String? orderBy = 'latest', String? stats, String? resolution = 'days', String? quantity, String? orientation = 'squarish'}) {
    // order_by: latest, oldest, popular, views, downloads,
    // orientation: landscape, portrait, squarish
    // resolution : days,
    Map<String, String> map = {
      'page': page.toString(),
      'per_page': perPage.toString(),
      'order_by': orderBy.toString(),
      'resolution': resolution.toString(),
      'orientation': orientation.toString(),
    };

    if (username != null) map.addAll({'orientation': jsonEncode(username)});
    if (stats != null) map.addAll({'stats': jsonEncode(stats)});
    if (quantity != null) map.addAll({'quantity': jsonEncode(quantity)});

    return map;
  }

  // List_photos
  static Map<String, String> paramsListProfile({String? username}) {
    // order_by: latest, oldest, popular, views, downloads,
    Map<String, String> map = {};
    if (username != null) map.addAll({'stats': jsonEncode(username)});
    return map;
  }


  // List_photos
  static Map<String, String> paramsPhotosList(
      {int? page = 1, int? perPage = 10, String? orderBy = 'latest',}) {
    // order_by: latest, oldest, popular, views, downloads,
    Map<String, String> map = {
      'page': page.toString(),
      'per_page': perPage.toString(),
      'order_by': orderBy.toString(),
    };
    return map;
  }

  // search_photos
  static Map<String, String> paramsSearchPhotos(
      {int? page = 0, int? perPage = 20,  String query = 'sports', String? collections, String? contentFilter = 'low', String? orderBy = 'popular', String? color = 'white', String? orientation = 'portrait'}) {
    // order_by: latest, oldest, popular, views, downloads,
    // content_filter: high
    // color: black_and_white, black, white, yellow, red, blue, teal, purple, magenta, green, orange
    // orientation: orientation, portrait, squarish
    Map<String, String> map = {
      'page': page.toString(),
      'per_page': perPage.toString(),
      'order_by': orderBy.toString(),
      'content_filter': contentFilter.toString(),
      'color': color.toString(),
      'orientation': orientation.toString(),
      'query': query.toString(),
    };

    // if (query != null) map.addAll({'orientation': jsonEncode(query)});
    if (collections != null) map.addAll({'stats': jsonEncode(collections)});

    return map;
  }

  // search Collections

  // List_photos
  static Map<String, String> paramsCollections(
      {int? page = 1, int? perPage = 10, String? query,}) {
    Map<String, String> map = {
      'page': page.toString(),
      'per_page': perPage.toString(),
    };
    if (query != null) map.addAll({'q': jsonEncode(query)});
    return map;
  }

  // List_photos
  static Map<String, String> paramsTopics(
      {int? page = 1, int? perPage = 10, String? id_or_slug, String? orientation = 'landscape', String? order_by = 'popular' }) {
    Map<String, String> map = {
      'page': page.toString(),
      'per_page': perPage.toString(),
      'orientation' : orientation.toString(),
      'order_by' : order_by.toString(),
    };
    if (id_or_slug != null) map.addAll({'id_or_slug': jsonEncode(id_or_slug)});
    return map;
  }


  // List Collections
  static Map<String, String> paramsListCollections(
      {int? page = 1, int? perPage = 10}) {
    Map<String, String> map = {
      'page': page.toString(),
      'per_page': perPage.toString(),
    };
    return map;
  }

  static Map<String, String> bodyFavourite(String imageId) {
    Map<String, String> map = {};

 map.addAll({'id': jsonEncode(imageId)});

    return map;

  }

}