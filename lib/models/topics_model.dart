
import 'dart:convert';

List<Topics> topicListFromJson(String str) {
  List list = jsonDecode(str);
  List<Topics> listTopic = list.map((item) => Topics.fromJson(item)).toList();
  return listTopic;
}
String topicListToJson(List<Topics> data) => jsonEncode(data.map((e) => e.toJson()).toList());


Topics topicFromJson(String str) => Topics.fromJson(json.decode(str));
String topicToJson(Topics data) => json.encode(data.toJson());


class Topics {
  Topics({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.promotedAt, 
      this.width, 
      this.height, 
      this.color, 
      this.blurHash, 
      this.description, 
      this.altDescription, 
      this.urls, 
      this.links, 
      this.categories, 
      this.likes, 
      this.likedByUser, 
      this.currentUserCollections, 
      this.sponsorship, 
      this.topicSubmissions, 
      this.user,});

  Topics.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promotedAt = json['promoted_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    description = json['description'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    if (json['categories'] != null) {
      categories = [];
      // json['categories'].forEach((v) {
      //   categories?.add(Dynamic.fromJson(v));
      // });
    }
    likes = json['likes'];
    likedByUser = json['liked_by_user'];
    if (json['current_user_collections'] != null) {
      currentUserCollections = [];
      // json['current_user_collections'].forEach((v) {
      //   currentUserCollections?.add(Dynamic.fromJson(v));
      // });
    }
    sponsorship = json['sponsorship'];
    topicSubmissions = json['topic_submissions'] != null ? TopicSubmissions.fromJson(json['topic_submissions']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? id;
  String? createdAt;
  String? updatedAt;
  dynamic promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  dynamic altDescription;
  Urls? urls;
  Links? links;
  List<dynamic>? categories;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  TopicSubmissions? topicSubmissions;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['promoted_at'] = promotedAt;
    map['width'] = width;
    map['height'] = height;
    map['color'] = color;
    map['blur_hash'] = blurHash;
    map['description'] = description;
    map['alt_description'] = altDescription;
    if (urls != null) {
      map['urls'] = urls?.toJson();
    }
    if (links != null) {
      map['links'] = links?.toJson();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['likes'] = likes;
    map['liked_by_user'] = likedByUser;
    if (currentUserCollections != null) {
      map['current_user_collections'] = currentUserCollections?.map((v) => v.toJson()).toList();
    }
    map['sponsorship'] = sponsorship;
    if (topicSubmissions != null) {
      map['topic_submissions'] = topicSubmissions?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.id, 
      this.updatedAt, 
      this.username, 
      this.name, 
      this.firstName, 
      this.lastName, 
      this.twitterUsername, 
      this.portfolioUrl, 
      this.bio, 
      this.location, 
      this.links, 
      this.profileImage, 
      this.instagramUsername, 
      this.totalCollections, 
      this.totalLikes, 
      this.totalPhotos, 
      this.acceptedTos, 
      this.forHire, 
      this.social,});

  User.fromJson(dynamic json) {
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
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
    instagramUsername = json['instagram_username'];
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    acceptedTos = json['accepted_tos'];
    forHire = json['for_hire'];
    social = json['social'] != null ? Social.fromJson(json['social']) : null;
  }
  String? id;
  String? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  dynamic twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  Links? links;
  ProfileImage? profileImage;
  dynamic instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['updated_at'] = updatedAt;
    map['username'] = username;
    map['name'] = name;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['twitter_username'] = twitterUsername;
    map['portfolio_url'] = portfolioUrl;
    map['bio'] = bio;
    map['location'] = location;
    if (links != null) {
      map['links'] = links?.toJson();
    }
    if (profileImage != null) {
      map['profile_image'] = profileImage?.toJson();
    }
    map['instagram_username'] = instagramUsername;
    map['total_collections'] = totalCollections;
    map['total_likes'] = totalLikes;
    map['total_photos'] = totalPhotos;
    map['accepted_tos'] = acceptedTos;
    map['for_hire'] = forHire;
    if (social != null) {
      map['social'] = social?.toJson();
    }
    return map;
  }

}

class Social {
  Social({
      this.instagramUsername, 
      this.portfolioUrl, 
      this.twitterUsername, 
      this.paypalEmail,});

  Social.fromJson(dynamic json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
    paypalEmail = json['paypal_email'];
  }
  dynamic instagramUsername;
  String? portfolioUrl;
  dynamic twitterUsername;
  dynamic paypalEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['instagram_username'] = instagramUsername;
    map['portfolio_url'] = portfolioUrl;
    map['twitter_username'] = twitterUsername;
    map['paypal_email'] = paypalEmail;
    return map;
  }

}

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

class Links {
  Links({
      this.self, 
      this.html, 
      this.photos, 
      this.likes, 
      this.portfolio, 
      this.following, 
      this.followers,});

  Links.fromJson(dynamic json) {
    self = json['self'];
    html = json['html'];
    photos = json['photos'];
    likes = json['likes'];
    portfolio = json['portfolio'];
    following = json['following'];
    followers = json['followers'];
  }
  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;
  String? following;
  String? followers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['self'] = self;
    map['html'] = html;
    map['photos'] = photos;
    map['likes'] = likes;
    map['portfolio'] = portfolio;
    map['following'] = following;
    map['followers'] = followers;
    return map;
  }

}

class TopicSubmissions {
  TopicSubmissions({
      this.businesswork, 
      this.drenders, 
      this.blockchain,});

  TopicSubmissions.fromJson(dynamic json) {
    businesswork = json['business-work'] != null ? BusinessWork.fromJson(json['business-work']) : null;
    drenders = json['3d-renders'] != null ? dRenders.fromJson(json['3d-renders']) : null;
    blockchain = json['blockchain'] != null ? Blockchain.fromJson(json['blockchain']) : null;
  }
  BusinessWork? businesswork;
  dRenders? drenders;
  Blockchain? blockchain;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (businesswork != null) {
      map['business-work'] = businesswork?.toJson();
    }
    if (drenders != null) {
      map['3d-renders'] = drenders?.toJson();
    }
    if (blockchain != null) {
      map['blockchain'] = blockchain?.toJson();
    }
    return map;
  }

}

class Blockchain {
  Blockchain({
      this.status, 
      this.approvedOn,});

  Blockchain.fromJson(dynamic json) {
    status = json['status'];
    approvedOn = json['approved_on'];
  }
  String? status;
  String? approvedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['approved_on'] = approvedOn;
    return map;
  }

}

class dRenders {
  dRenders({
      this.status, 
      this.approvedOn,});

  dRenders.fromJson(dynamic json) {
    status = json['status'];
    approvedOn = json['approved_on'];
  }
  String? status;
  String? approvedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['approved_on'] = approvedOn;
    return map;
  }
}

class BusinessWork {
  BusinessWork({
      this.status, 
      this.approvedOn,});

  BusinessWork.fromJson(dynamic json) {
    status = json['status'];
    approvedOn = json['approved_on'];
  }
  String? status;
  String? approvedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['approved_on'] = approvedOn;
    return map;
  }

}
 

class Urls {
  Urls({
      this.raw, 
      this.full, 
      this.regular, 
      this.small, 
      this.thumb, 
      this.smallS3,});

  Urls.fromJson(dynamic json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = raw;
    map['full'] = full;
    map['regular'] = regular;
    map['small'] = small;
    map['thumb'] = thumb;
    map['small_s3'] = smallS3;
    return map;
  }

}