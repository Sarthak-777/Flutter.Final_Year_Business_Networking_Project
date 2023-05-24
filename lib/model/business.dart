// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Business {
  String? email;
  String? orgName;
  String? password;
  String? phoneNo;

  String? jobCategory;
  String? jobDesc;
  String? profilePhoto;
  String? uid;
  String? type;
  List? orgNameSubstring;

  Business(
      {this.email,
      this.orgName,
      this.password,
      this.phoneNo,
      this.jobCategory,
      this.jobDesc,
      this.profilePhoto,
      this.uid,
      this.type,
      this.orgNameSubstring});

  Business copyWith({
    String? email,
    String? orgName,
    String? password,
    String? phoneNo,
    String? jobCategory,
    String? jobDesc,
    String? profilePhoto,
    String? uid,
    String? type,
  }) {
    return Business(
      email: email ?? this.email,
      orgName: orgName ?? this.orgName,
      password: password ?? this.password,
      phoneNo: phoneNo ?? this.phoneNo,
      jobCategory: jobCategory ?? this.jobCategory,
      jobDesc: jobDesc ?? this.jobDesc,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'orgName': orgName,
      'password': password,
      'phoneNo': phoneNo,
      'jobCategory': jobCategory,
      'jobDesc': jobDesc,
      'profilePhoto': profilePhoto,
      'uid': uid,
      'type': type,
      'orgNameSubstring': orgNameSubstring,
    };
  }

  Business.fromMap(Map<String, dynamic> map) {
    email = map["email"];
    orgName = map["orgName"];
    phoneNo = map["phoneNo"];
    jobCategory = map["jobCategory"];
    jobDesc = map["jobDesc"];
    profilePhoto = map["profilePhoto"];
    uid = map["uid"];
    type = map["type"];
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Business(email: $email, orgName: $orgName, password: $password, phoneNo: $phoneNo, jobCategory: $jobCategory, jobDesc: $jobDesc, profilePhoto: $profilePhoto, uid: $uid)';
  }

  @override
  bool operator ==(covariant Business other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.orgName == orgName &&
        other.password == password &&
        other.phoneNo == phoneNo &&
        other.jobCategory == jobCategory &&
        other.jobDesc == jobDesc &&
        other.profilePhoto == profilePhoto &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        orgName.hashCode ^
        password.hashCode ^
        phoneNo.hashCode ^
        jobCategory.hashCode ^
        jobDesc.hashCode ^
        profilePhoto.hashCode ^
        uid.hashCode;
  }
}
