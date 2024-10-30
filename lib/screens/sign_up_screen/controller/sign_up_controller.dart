import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  RxBool passwordVisibility = false.obs;
  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mailController.text.trim() + "@mail.baskent.edu.tr",
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();

    await user.reload();

    Get.back();
  }

  checkMail() {
    if (mailController.text.isNumericOnly) {
      signUp();
    } else {
      Get.defaultDialog(
        title: "HATA!",
        content: Text(
          "Öğrenci numaranızın doğru olup olmadığını kontrol edin.",
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  checkLength() {
    if (passwordController.text.length >= 8 &&
        passwordController.text.length <= 16) {
      checkMail();
    } else {
      Get.defaultDialog(
        title: "HATA!",
        content: Text(
          "Şifreniz en az 8 en fazla 16 karakter uzunluğunda olmalıdır.",
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  checkEmpty() {
    if (nameController.text.isEmpty ||
        surnameController.text.isEmpty ||
        mailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        rePasswordController.text.isEmpty) {
      Get.defaultDialog(
        title: "HATA!",
        content: Text(
          "Tüm alanlar dolu olmalı.",
          textAlign: TextAlign.center,
        ),
      );
    } else {
      checkPasswords();
    }
  }

  checkPasswords() {
    if (passwordController.text == rePasswordController.text) {
      checkLength();
    } else {
      Get.defaultDialog(
        title: "HATA!",
        content: Text(
          "Şifreleriniz aynı olmalı.",
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
