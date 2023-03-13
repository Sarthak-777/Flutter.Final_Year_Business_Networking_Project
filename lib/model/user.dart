// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyUser {
  String email;
  String username;
  String password;
  String country;
  String city;
  String phoneNo;
  String working;
  String jobCategory;
  String jobDesc;
  String profilePhoto;
  String uid;

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
  });

  MyUser copyWith({
    String? email,
    String? username,
    String? password,
    String? country,
    String? city,
    String? phoneNo,
    String? working,
    String? jobCategory,
    String? jobDesc,
    String? profilePhoto,
    String? uid,
  }) {
    return MyUser(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      country: country ?? this.country,
      city: city ?? this.city,
      phoneNo: phoneNo ?? this.phoneNo,
      working: working ?? this.working,
      jobCategory: jobCategory ?? this.jobCategory,
      jobDesc: jobDesc ?? this.jobDesc,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      uid: uid ?? this.uid,
    );
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
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      phoneNo: map['phoneNo'] as String,
      working: map['working'] as String,
      jobCategory: map['jobCategory'] as String,
      jobDesc: map['jobDesc'] as String,
      profilePhoto: map['profilePhoto'] as String,
      uid: map['uid'] as String,
    );
  }

  @override
  String toString() {
    return 'User(email: $email, username: $username, password: $password, country: $country, city: $city, phoneNo: $phoneNo, working: $working, jobCategory: $jobCategory, jobDesc: $jobDesc, profilePhoto: $profilePhoto, uid: $uid)';
  }

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.username == username &&
        other.password == password &&
        other.country == country &&
        other.city == city &&
        other.phoneNo == phoneNo &&
        other.working == working &&
        other.jobCategory == jobCategory &&
        other.jobDesc == jobDesc &&
        other.profilePhoto == profilePhoto &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        username.hashCode ^
        password.hashCode ^
        country.hashCode ^
        city.hashCode ^
        phoneNo.hashCode ^
        working.hashCode ^
        jobCategory.hashCode ^
        jobDesc.hashCode ^
        profilePhoto.hashCode ^
        uid.hashCode;
  }
}
