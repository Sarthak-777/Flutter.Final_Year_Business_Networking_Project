import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_workconnect/model/user.dart';
import 'package:final_project_workconnect/view/screens/auth/google_login.dart';
import 'package:final_project_workconnect/view/screens/auth/login_screen.dart';
import 'package:final_project_workconnect/view/screens/auth/verify.dart';
import 'package:final_project_workconnect/view/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  late Rx<User?> _user;

  User get user => _user.value!;
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
      Get.offAll(() => HomeScreen());
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
          UserCredential cred = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
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
            profilePhoto: '',
            uid: cred.user!.uid,
          );

          await FirebaseFirestore.instance
              .collection('users')
              .doc(cred.user!.uid)
              .set(user.toMap());
          await FirebaseFirestore.instance
              .collection('email')
              .doc(email)
              .set({"email": email});

          Get.to(VerifyScreen());
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
      profilePhoto: '',
      uid: uid,
    );
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(user.toMap());
      Get.off(HomeScreen());
    } catch (e) {
      Get.snackbar("error", e.toString());
      ;
    }
  }

  void loginWithEmalAndPassword(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Get.off(() => HomeScreen());
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
      await FirebaseFirestore.instance
          .collection('email')
          .doc(userCred.user!.email)
          .set({"email": userCred.user!.email});
      try {
        print(allData);
        for (var data in allData) {
          if (userCred.user!.email == (data as Map)['email']) {
            print('home');
            Get.off(() => HomeScreen());
            break;
          } else {
            print('google');
            Get.to(() => GoogleLogin(), arguments: [userCred]);
          }
        }
      } catch (e) {
        log(e.toString());
      }
    } catch (e) {
      Get.snackbar("Failed", "Sign in Failed");
    }
  }

  void sendPasswordResetEmail(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
