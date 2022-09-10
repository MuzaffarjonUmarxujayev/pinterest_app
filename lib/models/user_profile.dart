import 'dart:convert';

List<UserProfile> userProfileListFromJson(String str) {
  List list = jsonDecode(str);
  List<UserProfile> listUserProfile = list.map((item) => UserProfile.fromJson(item)).toList();
  return listUserProfile;
}
String userProfileListToJson(List<UserProfile> data) => jsonEncode(data.map((e) => e.toJson()).toList());


UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));
String userProfileToJson(UserProfile data) => json.encode(data.toJson());
class UserProfile {
  UserProfile({
      this.id, 
      this.updatedAt, 
      this.username, 
      this.name, 
      this.firstName, 
      this.lastName, 
      this.instagramUsername, 
      this.twitterUsername, 
      this.portfolioUrl, 
      this.bio, 
      this.location, 
      this.totalLikes, 
      this.totalPhotos, 
      this.totalCollections, 
      this.followedByUser, 
      this.followersCount, 
      this.followingCount, 
      this.downloads, 
      this.social, 
      this.profileImage, 
      this.badge, 
      this.links,});

  UserProfile.fromJson(dynamic json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    instagramUsername = json['instagram_username'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    totalCollections = json['total_collections'];
    followedByUser = json['followed_by_user'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    downloads = json['downloads'];
    social = json['social'] != null ? Social.fromJson(json['social']) : null;
    profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
    badge = json['badge'] != null ? Badge.fromJson(json['badge']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  String? id;
  String? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? instagramUsername;
  String? twitterUsername;
  dynamic portfolioUrl;
  String? bio;
  String? location;
  int? totalLikes;
  int? totalPhotos;
  int? totalCollections;
  bool? followedByUser;
  int? followersCount;
  int? followingCount;
  int? downloads;
  Social? social;
  ProfileImage? profileImage;
  Badge? badge;
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['updated_at'] = updatedAt;
    map['username'] = username;
    map['name'] = name;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['instagram_username'] = instagramUsername;
    map['twitter_username'] = twitterUsername;
    map['portfolio_url'] = portfolioUrl;
    map['bio'] = bio;
    map['location'] = location;
    map['total_likes'] = totalLikes;
    map['total_photos'] = totalPhotos;
    map['total_collections'] = totalCollections;
    map['followed_by_user'] = followedByUser;
    map['followers_count'] = followersCount;
    map['following_count'] = followingCount;
    map['downloads'] = downloads;
    if (social != null) {
      map['social'] = social?.toJson();
    }
    if (profileImage != null) {
      map['profile_image'] = profileImage?.toJson();
    }
    if (badge != null) {
      map['badge'] = badge?.toJson();
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
      this.photos, 
      this.likes, 
      this.portfolio,});

  Links.fromJson(dynamic json) {
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

Badge badgeFromJson(String str) => Badge.fromJson(json.decode(str));
String badgeToJson(Badge data) => json.encode(data.toJson());
class Badge {
  Badge({
      this.title, 
      this.primary, 
      this.slug, 
      this.link,});

  Badge.fromJson(dynamic json) {
    title = json['title'];
    primary = json['primary'];
    slug = json['slug'];
    link = json['link'];
  }
  String? title;
  bool? primary;
  String? slug;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['primary'] = primary;
    map['slug'] = slug;
    map['link'] = link;
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

Social socialFromJson(String str) => Social.fromJson(json.decode(str));
String socialToJson(Social data) => json.encode(data.toJson());
class Social {
  Social({
      this.instagramUsername, 
      this.portfolioUrl, 
      this.twitterUsername,});

  Social.fromJson(dynamic json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
  }
  String? instagramUsername;
  String? portfolioUrl;
  String? twitterUsername;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['instagram_username'] = instagramUsername;
    map['portfolio_url'] = portfolioUrl;
    map['twitter_username'] = twitterUsername;
    return map;
  }

}