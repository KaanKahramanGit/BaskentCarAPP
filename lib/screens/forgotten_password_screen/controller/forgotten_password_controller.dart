import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgottenPasswordController extends GetxController {
  TextEditingController okulnoController = TextEditingController();
  //TextEditingController checkDbController = TextEditingController();
  checkSchoolNumber() {
    if (okulnoController.text.isNumericOnly) {
      //dispose();
      checkDatabase();
    } else {
      Get.defaultDialog(
        title: "HATA!",
        content: Text(
          "Öğrenci numaranızı doğru yazdığınıza emin olun.",
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  void dispose() {
    okulnoController.dispose();
    super.dispose();
    checkDatabase();
  }

  Future checkDatabase() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: okulnoController.text.trim() + "@mail.baskent.edu.tr",
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    Get.back();
  }
}
