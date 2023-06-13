// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyUser {
  String? email;
  String? username;
  String? password;
  String? country;
  String? city;
  String? phoneNo;
  String? working;
  String? jobCategory;
  String? jobDesc;
  String? profilePhoto;
  String? uid;
  List? skills;
  String? type;
  String? color;
  List? usernameSubstring;
  List? followers;
  List? following;
  List? recommendation;

  MyUser({
    required this.email,
    required this.username,
    required this.password,
    required this.country,
    required this.city,
    required this.phoneNo,
    required this.working,
    required this.jobCategory,
    required this.jobDesc,
    required this.profilePhoto,
    required this.uid,
    required this.skills,
    required this.type,
    required this.color,
    required this.usernameSubstring,
    required this.followers,
    required this.following,
    required this.recommendation,
  });

  MyUser.fromMap(Map<String, dynamic> map) {
    city = map["city"];
    email = map["email"];
    username = map["username"];
    uid = map["uid"];
    profilePhoto = map["profilePhoto"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'username': username,
      'password': password,
      'country': country,
      'city': city,
      'phoneNo': phoneNo,
      'working': working,
      'jobCategory': jobCategory,
      'jobDesc': jobDesc,
      'profilePhoto': profilePhoto,
      'uid': uid,
      'skills': skills,
      'type': type,
      'color': color,
      'usernameSubstring': usernameSubstring,
      'followers': followers,
      'following': following,
      'recommendation': recommendation,
    };
  }

  String toJson() => json.encode(toMap());
}
