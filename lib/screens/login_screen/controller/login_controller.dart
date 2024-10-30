import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool switchButton = false.obs;
  //Rx passwordVisibility=false.obs;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mailController.text.trim() + "@mail.baskent.edu.tr",
      password: passwordController.text,
    );
  }
 
}
