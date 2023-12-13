import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:pos_admin/src/views/auth_views/login_view.dart';
import 'package:pos_admin/src/views/home_views/all_users_list_view.dart';
import 'package:pos_admin/src/views/home_views/home_view.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  checkLoggedInOrNot() async {
    await Future.delayed(const Duration(seconds: 2));
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(() => SignINView());
      } else {
        print('User is signed in!');
        Get.offAll(const AllUsersView());
      }
    });
  }

  signIn(context, String email, String password) async {
    isLoading(true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoading(false);
      Get.offAll(const AllUsersView());
      Get.snackbar("Successfully Logged in", "",
          maxWidth: 400,
          colorText: Colors.white,
          backgroundColor: Colors.green);
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      if (e.code == 'user-not-found') {
        Get.snackbar("Invalid Username/Password", "",
            maxWidth: 400,
            colorText: Colors.white,
            backgroundColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Invalid Password", "",
            maxWidth: 400,
            colorText: Colors.white,
            backgroundColor: Colors.red);
      }else{
         Get.snackbar("Something went wrong", "${e.code}",
            maxWidth: 400,
            colorText: Colors.white,
            backgroundColor: Colors.red);
      }
    }
  }
}
