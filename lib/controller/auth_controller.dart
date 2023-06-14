import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/constants.dart';
import 'package:final_project_workconnect/functions/checkValidEmail.dart';
import 'package:final_project_workconnect/model/business.dart';
import 'package:final_project_workconnect/model/user.dart';
import 'package:final_project_workconnect/view/screens/auth/google_login.dart';
import 'package:final_project_workconnect/view/screens/auth/login_screen.dart';
import 'package:final_project_workconnect/view/screens/auth/verify.dart';
import 'package:final_project_workconnect/view/screens/business/business_home_screen.dart';
import 'package:final_project_workconnect/view/screens/business/business_landing_screen.dart';
import 'package:final_project_workconnect/view/screens/user/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:final_project_workconnect/functions/subString.dart';

class AuthController extends GetxController {
  late Rx<User?> _user;
  // late Rx<Business?> _business;
  User get user => _user.value!;
  // User get business => _user.value!;

  final Rx<Map<String, dynamic>> _userData = Rx<Map<String, dynamic>>({});
  // final Rx<Map<String, dynamic>> _businessData = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get userData => _userData.value;

  static AuthController instance = Get.find();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      if (user.displayName == "job-seeker") {
        Get.offAll(() => DashboardScreen());
        // Get.offAll(() => LoginScreen());
        // FirebaseAuth.instance.signOut();
      } else if (user.displayName == "employer") {
        Get.offAll(() => LandingScreen());
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  getUserData() async {
    var userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    final userData = userDoc.data() as dynamic;
    String uid = userDoc['uid'];
    String username = userDoc['username'];
    String jobCategory = userDoc['jobCategory'];
    String profilePhoto = userDoc['profilePhoto'];
    String country = userDoc['country'];
    String city = userDoc['city'];
    String jobDesc = userDoc['jobDesc'];
    String color = userDoc['color'];
    List skills = userDoc['skills'];
    List followers = userDoc['followers'];
    List following = userDoc['following'];

    return _userData.value = {
      'uid': uid,
      'followers': followers,
      'following': following,
      'profilePhoto': profilePhoto,
      'username': username,
      'country': country,
      'jobCategory': jobCategory,
      'city': city,
      'jobDesc': jobDesc,
      'color': color,
      'skills': skills,
    };
  }

  getUserDataWithUid(String userId) async {
    var userDoc =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    final userData = userDoc.data() as dynamic;
    String uid = userDoc['uid'];
    String username = userDoc['username'];
    String jobCategory = userDoc['jobCategory'];
    String profilePhoto = userDoc['profilePhoto'];
    String country = userDoc['country'];
    String city = userDoc['city'];
    String jobDesc = userDoc['jobDesc'];
    String color = userDoc['color'];
    List skills = userDoc['skills'];
    List followers = userDoc['followers'];
    List following = userDoc['following'];

    return _userData.value = {
      'uid': uid,
      'followers': followers,
      'following': following,
      'profilePhoto': profilePhoto,
      'username': username,
      'country': country,
      'jobCategory': jobCategory,
      'city': city,
      'jobDesc': jobDesc,
      'color': color,
      'skills': skills,
    };
  }

  getBusinessData() async {
    var businessDoc = await FirebaseFirestore.instance
        .collection("business")
        .doc(user.uid)
        .get();
    final userData = businessDoc.data() as dynamic;
    String uid = businessDoc['uid'];
    String orgName = businessDoc['orgName'];
    String jobCategory = businessDoc['jobCategory'];
    String profilePhoto = businessDoc['profilePhoto'];
    String phoneNo = businessDoc['phoneNo'];
    String type = businessDoc['type'];
    String jobDesc = businessDoc['jobDesc'];

    int followers = 0;
    int following = 0;
    return _userData.value = {
      'uid': uid,
      'followers': followers.toString(),
      'following': following.toString(),
      'profilePhoto': profilePhoto,
      'orgName': orgName,
      'phoneNo': phoneNo,
      'jobCategory': jobCategory,
      'type': type,
      'jobDesc': jobDesc,
    };
  }

  getColorData(String id) async {
    var userDoc =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    final userData = userDoc.data() as dynamic;
    String color = userDoc['color'];

    return color;
  }

  void businessSignUp(String jobCategory, String orgName, String phoneNo,
      String email, String password) async {
    try {
      if (email.isNotEmpty &&
          orgName.isNotEmpty &&
          password.isNotEmpty &&
          email.isNotEmpty &&
          phoneNo.isNotEmpty &&
          password.isNotEmpty &&
          jobCategory.isNotEmpty) {
        try {
          UserCredential cred = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          cred.user!.updateDisplayName('employer');
          List orgNameSubstring = createSubString(orgName);

          Business business = Business(
            email: email,
            orgName: orgName,
            password: password,
            phoneNo: phoneNo,
            jobCategory: jobCategory,
            jobDesc: '',
            profilePhoto:
                'https://github.com/Sarthak-777/FInal_Project_flutter_Buness_Networking_System/blob/main/assets/person.jpg?raw=true',
            uid: cred.user!.uid,
            type: 'employer',
            orgNameSubstring: orgNameSubstring,
            followers: [],
          );

          await FirebaseFirestore.instance
              .collection('business')
              .doc(cred.user!.uid)
              .set(business.toMap());
          await FirebaseFirestore.instance
              .collection('email')
              .doc(email)
              .set({"email": email});
          Get.offAll(() => LandingScreen());

          // Get.to(VerifyScreen());
        } on FirebaseAuthException catch (e) {
          Get.snackbar("Error", e.code);
        }
      } else {
        Get.snackbar("Error", "Please enter all the required data");
      }
    } catch (e) {
      Get.snackbar("Error Creating Account", "Check your credentials");
      log(e.toString());
    }
  }

  void signUp(String email, String username, String password, String country,
      String city, String phoneNo, String work, String jobCategory) async {
    try {
      if (email.isNotEmpty &&
          username.isNotEmpty &&
          password.isNotEmpty &&
          country.isNotEmpty &&
          city.isNotEmpty &&
          phoneNo.isNotEmpty &&
          work.isNotEmpty &&
          jobCategory.isNotEmpty) {
        try {
          String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
          RegExp emailRegex = RegExp(pattern);
          RegExp regex = RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
          if (!regex.hasMatch(password)) {
            Get.snackbar("Error",
                "Password should atlease have 1 capital letter, a symbol and a number. Please try again",
                colorText: Colors.black, backgroundColor: Colors.white);
          } else if (!emailRegex.hasMatch(email)) {
            Get.snackbar("Error", "Please enter valid email address",
                colorText: Colors.black, backgroundColor: Colors.white);
          } else {
            UserCredential cred = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: email, password: password);
            cred.user!.updateDisplayName('job-seeker');
            List usernameSubstring = createSubString(username);

            MyUser user = MyUser(
              email: email,
              username: username,
              password: password,
              country: country,
              city: city,
              phoneNo: phoneNo,
              working: work,
              jobCategory: jobCategory,
              jobDesc: '',
              profilePhoto:
                  'https://github.com/Sarthak-777/FInal_Project_flutter_Buness_Networking_System/blob/main/assets/person.jpg?raw=true',
              uid: cred.user!.uid,
              skills: [],
              type: 'job-seeker',
              color: 'red',
              usernameSubstring: usernameSubstring,
              followers: [],
              following: [],
              recommendation: [],
            );

            await FirebaseFirestore.instance
                .collection('users')
                .doc(cred.user!.uid)
                .set(user.toMap());
            await FirebaseFirestore.instance
                .collection('email')
                .doc(email)
                .set({"email": email});

            Get.offAll(VerifyScreen());
          }
        } on FirebaseAuthException catch (e) {
          Get.snackbar("Error", e.code);
        }
      } else {
        Get.snackbar("Error", "Please enter all the required data");
      }
    } catch (e) {
      Get.snackbar("Error Creating Account", "Check your credentials");
      log(e.toString());
    }
  }

  void googleAdditionalInfoPage(
      String uid,
      String email,
      String username,
      String country,
      String city,
      String phoneNo,
      String working,
      String jobCategory) async {
    List usernameSubstring = createSubString(username);
    if (username.isNotEmpty &
        country.isNotEmpty &
        city.isNotEmpty &
        phoneNo.isNotEmpty &
        working.isNotEmpty &
        jobCategory.isNotEmpty) {
      MyUser user = MyUser(
          email: email,
          username: username,
          password: "google auth",
          country: country,
          city: city,
          phoneNo: phoneNo,
          working: working,
          jobCategory: jobCategory,
          jobDesc: '',
          profilePhoto:
              'https://github.com/Sarthak-777/FInal_Project_flutter_Buness_Networking_System/blob/main/assets/person.jpg?raw=true',
          uid: uid,
          skills: [],
          type: 'job-seeker',
          color: 'red',
          usernameSubstring: usernameSubstring,
          followers: [],
          following: [],
          recommendation: []);
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(user.toMap());
        Get.off(DashboardScreen());
      } catch (e) {
        Get.snackbar("error", e.toString());
      }
    } else {
      Get.snackbar("Error", "Please enter all fields");
    }
  }

  Future<bool> checkEmailExists(String email) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    final QuerySnapshot snapshot =
        await usersCollection.where('email', isEqualTo: email).limit(1).get();

    return snapshot.size > 0;
  }

  Future<bool> checkBusinessEmailExists(String email) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('business');

    final QuerySnapshot snapshot =
        await usersCollection.where('email', isEqualTo: email).limit(1).get();

    return snapshot.size > 0;
  }

  void loginWithEmalAndPassword(String email, String password) async {
    bool emailExists = await checkEmailExists(email);
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        if (emailExists) {
          if (validEmail(email)) {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
            Get.offAll(() => DashboardScreen());
          }
        } else {
          Get.snackbar("Error", "Email does not exist",
              backgroundColor: Colors.white, colorText: Colors.black);
        }
      } else {
        Get.snackbar("Error", "Fill both the forms below");
      }
    } catch (e) {
      Get.snackbar("Error logging in ", "Email or password incorrect");
    }
  }

  void businessLoginWithEmailAndPassword(String email, String password) async {
    bool emailExists = await checkBusinessEmailExists(email);

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        if (emailExists) {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          Get.offAll(() => LandingScreen());
        } else {
          Get.snackbar("Error", "Email does not exist",
              backgroundColor: Colors.white, colorText: Colors.black);
        }
      } else {
        Get.snackbar("Error", "Fill both the forms below");
      }
    } catch (e) {
      Get.snackbar("Error logging in ", "Email or password incorrect");
    }
  }

  void googleSignIn() async {
    CollectionReference ref = FirebaseFirestore.instance.collection("email");
    try {
      QuerySnapshot snapshot = await ref.get();
      final allData = snapshot.docs.map((doc) => doc.data()).toList();
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential cred = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential userCred =
          await FirebaseAuth.instance.signInWithCredential(cred);

      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('email')
            .doc(userCred.user!.email)
            .get();
        if (snapshot.exists) {
          print('Document exists.');
          Get.offAll(() => DashboardScreen());
        } else {
          await FirebaseFirestore.instance
              .collection('email')
              .doc(userCred.user!.email)
              .set({"email": userCred.user!.email});
          Get.to(() => GoogleLogin(), arguments: [userCred]);

          print('Document does not exist.');
        }
        // print(userCred.user!.email);
        // for (var data in allData) {
        //   print((data as Map)['email']);

        //   if (userCred.user!.email == (data as Map)['email']) {
        //     Get.offAll(() => DashboardScreen());
        //   } else {
        //     Get.to(() => GoogleLogin(), arguments: [userCred]);
        //   }
        // }
      } catch (e) {
        // log(e.toString());
      }
    } catch (e) {
      print(e);
      Get.snackbar("Failed", "Sign in Failed");
    }
  }

  void sendPasswordResetEmail(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
