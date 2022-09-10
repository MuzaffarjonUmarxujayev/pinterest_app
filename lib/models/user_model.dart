import 'dart:convert';

List<User> userListFromJson(String str) {
  List list = jsonDecode(str);
  List<User> listUser = list.map((item) => User.fromJson(item)).toList();
  return listUser;
}
String userListToJson(List<User> data) => jsonEncode(data.map((e) => e.toJson()).toList());


User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.width, 
      this.height, 
      this.color, 
      this.blurHash, 
      this.likes, 
      this.likedByUser, 
      this.description, 
      this.user, 
      this.currentUserCollections, 
      this.urls, 
      this.links,});

  User.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    likes = json['likes'];
    likedByUser = json['liked_by_user'];
    description = json['description'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['current_user_collections'] != null) {
      currentUserCollections = [];
      json['current_user_collections'].forEach((v) {
        currentUserCollections?.add(CurrentUserCollections.fromJson(v));
      });
    }
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  int? likes;
  bool? likedByUser;
  String? description;
  User? user;
  List<CurrentUserCollections>? currentUserCollections;
  Urls? urls;
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['width'] = width;
    map['height'] = height;
    map['color'] = color;
    map['blur_hash'] = blurHash;
    map['likes'] = likes;
    map['liked_by_user'] = likedByUser;
    map['description'] = description;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (currentUserCollections != null) {
      map['current_user_collections'] = currentUserCollections?.map((v) => v.toJson()).toList();
    }
    if (urls != null) {
      map['urls'] = urls?.toJson();
    }
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());
class Links {
  Links({
      this.self, 
      this.html, 
      this.download, 
      this.downloadLocation,});

  Links.fromJson(dynamic json) {
    self = json['self'];
    html = json['html'];
    download = json['download'];
    downloadLocation = json['download_location'];
  }
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['self'] = self;
    map['html'] = html;
    map['download'] = download;
    map['download_location'] = downloadLocation;
    return map;
  }

}


List<Urls> utilsListFromJson(String str) {
  List list = jsonDecode(str);
  List<Urls> listUser = list.map((item) => Urls.fromJson(item)).toList();
  return listUser;
}
String utilsListToJson(List<User> data) => jsonEncode(data.map((e) => e.toJson()).toList());



Urls urlsFromJson(String str) => Urls.fromJson(json.decode(str));
String urlsToJson(Urls data) => json.encode(data.toJson());
class Urls {
  Urls({
      this.raw, 
      this.full, 
      this.regular, 
      this.small, 
      this.thumb,});

  Urls.fromJson(dynamic json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
  }
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = raw;
    map['full'] = full;
    map['regular'] = regular;
    map['small'] = small;
    map['thumb'] = thumb;
    return map;
  }

}

CurrentUserCollections currentUserCollectionsFromJson(String str) => CurrentUserCollections.fromJson(json.decode(str));
String currentUserCollectionsToJson(CurrentUserCollections data) => json.encode(data.toJson());
class CurrentUserCollections {
  CurrentUserCollections({
      this.id, 
      this.title, 
      this.publishedAt, 
      this.lastCollectedAt, 
      this.updatedAt, 
      this.coverPhoto, 
      this.user,});

  CurrentUserCollections.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    publishedAt = json['published_at'];
    lastCollectedAt = json['last_collected_at'];
    updatedAt = json['updated_at'];
    coverPhoto = json['cover_photo'];
    user = json['user'];
  }
  int? id;
  String? title;
  String? publishedAt;
  String? lastCollectedAt;
  String? updatedAt;
  dynamic coverPhoto;
  dynamic user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['published_at'] = publishedAt;
    map['last_collected_at'] = lastCollectedAt;
    map['updated_at'] = updatedAt;
    map['cover_photo'] = coverPhoto;
    map['user'] = user;
    return map;
  }

}

UserTwo userTwoFromJson(String str) => UserTwo.fromJson(json.decode(str));
String userTwoToJson(User data) => json.encode(data.toJson());
class UserTwo {
  UserTwo({
      this.id, 
      this.username, 
      this.name, 
      this.portfolioUrl, 
      this.bio, 
      this.location, 
      this.totalLikes, 
      this.totalPhotos, 
      this.totalCollections, 
      this.instagramUsername, 
      this.twitterUsername, 
      this.profileImage, 
      this.links,});

  UserTwo.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    totalCollections = json['total_collections'];
    instagramUsername = json['instagram_username'];
    twitterUsername = json['twitter_username'];
    profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  String? id;
  String? username;
  String? name;
  String? portfolioUrl;
  String? bio;
  String? location;
  int? totalLikes;
  int? totalPhotos;
  int? totalCollections;
  String? instagramUsername;
  String? twitterUsername;
  ProfileImage? profileImage;
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['name'] = name;
    map['portfolio_url'] = portfolioUrl;
    map['bio'] = bio;
    map['location'] = location;
    map['total_likes'] = totalLikes;
    map['total_photos'] = totalPhotos;
    map['total_collections'] = totalCollections;
    map['instagram_username'] = instagramUsername;
    map['twitter_username'] = twitterUsername;
    if (profileImage != null) {
      map['profile_image'] = profileImage?.toJson();
    }
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

Links linksTwoTwoFromJson(String str) => Links.fromJson(json.decode(str));
String linksTwoTwoToJson(Links data) => json.encode(data.toJson());
class LinksTwo {
  LinksTwo({
      this.self, 
      this.html, 
      this.photos, 
      this.likes, 
      this.portfolio,});

  LinksTwo.fromJson(dynamic json) {
    self = json['self'];
    html = json['html'];
    photos = json['photos'];
    likes = json['likes'];
    portfolio = json['portfolio'];
  }
  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['self'] = self;
    map['html'] = html;
    map['photos'] = photos;
    map['likes'] = likes;
    map['portfolio'] = portfolio;
    return map;
  }

}

ProfileImage profileImageFromJson(String str) => ProfileImage.fromJson(json.decode(str));
String profileImageToJson(ProfileImage data) => json.encode(data.toJson());
class ProfileImage {
  ProfileImage({
      this.small, 
      this.medium, 
      this.large,});

  ProfileImage.fromJson(dynamic json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }
  String? small;
  String? medium;
  String? large;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['small'] = small;
    map['medium'] = medium;
    map['large'] = large;
    return map;
  }

}









class Sponsorship {
  List<String>? impressionUrls;
  String? tagline;
  String? taglineUrl;
  Sponsor? sponsor;

  Sponsorship({this.impressionUrls, this.tagline, this.taglineUrl, this.sponsor});

  Sponsorship.fromJson(Map<String, dynamic> json) {
    impressionUrls = json['impression_urls'].cast<String>();
    tagline = json['tagline'];
    taglineUrl = json['tagline_url'];
    sponsor = json['sponsor'] != null ? new Sponsor.fromJson(json['sponsor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['impression_urls'] = this.impressionUrls;
    data['tagline'] = this.tagline;
    data['tagline_url'] = this.taglineUrl;
    if (this.sponsor != null) {
      data['sponsor'] = this.sponsor!.toJson();
    }
    return data;
  }
}

class Sponsor {
  String? id;
  String? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  Links? links;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  Sponsor({this.id, this.updatedAt, this.username, this.name, this.firstName, this.lastName, this.twitterUsername, this.portfolioUrl, this.bio, this.location, this.links, this.profileImage, this.instagramUsername, this.totalCollections, this.totalLikes, this.totalPhotos, this.acceptedTos, this.forHire, this.social});

  Sponsor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    profileImage = json['profile_image'] != null ? new ProfileImage.fromJson(json['profile_image']) : null;
    instagramUsername = json['instagram_username'];
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    acceptedTos = json['accepted_tos'];
    forHire = json['for_hire'];
    social = json['social'] != null ? new Social.fromJson(json['social']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['twitter_username'] = this.twitterUsername;
    data['portfolio_url'] = this.portfolioUrl;
    data['bio'] = this.bio;
    data['location'] = this.location;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['instagram_username'] = this.instagramUsername;
    data['total_collections'] = this.totalCollections;
    data['total_likes'] = this.totalLikes;
    data['total_photos'] = this.totalPhotos;
    data['accepted_tos'] = this.acceptedTos;
    data['for_hire'] = this.forHire;
    if (this.social != null) {
      data['social'] = this.social!.toJson();
    }
    return data;
  }
}




class Social {
  String? instagramUsername;
  String? portfolioUrl;
  Null? twitterUsername;
  Null? paypalEmail;

  Social({this.instagramUsername, this.portfolioUrl, this.twitterUsername, this.paypalEmail});

  Social.fromJson(Map<String, dynamic> json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
    paypalEmail = json['paypal_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instagram_username'] = this.instagramUsername;
    data['portfolio_url'] = this.portfolioUrl;
    data['twitter_username'] = this.twitterUsername;
    data['paypal_email'] = this.paypalEmail;
    return data;
  }
}


