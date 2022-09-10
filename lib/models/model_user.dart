

class ModelUser {
  late String userId;
  late String firstname;
  late String lastname;
  late String email;

  ModelUser({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.email,
   });

  ModelUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
  };
}