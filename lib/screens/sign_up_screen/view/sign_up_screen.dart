import 'package:baskent_car_app/screens/sign_up_screen/controller/sign_up_controller.dart';
import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 93, 160, 214),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: SizedBox(
              height: 90.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 2.h),
                  infoRow("Ad", signUpController.nameController),
                  infoRow("Soyad", signUpController.surnameController),
                  infoRow("Okul Numarası", signUpController.mailController),
                  infoPassRow("Şifre", signUpController.passwordController),
                  infoPassRow(
                      "Şifre Tekrar", signUpController.rePasswordController),
                  signUpButton(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container signUpButton() {
    return Container(
      alignment: Alignment.center,
      child: CustomElevatedButton(
        height: 6.h,
        width: 30.w,
        text: "Kayıt Ol",
        backgroundColor: AppColors.whiteColor,
        onPressed: () {
          signUpController.checkEmpty();
        },
      ),
    );
  }

  Row infoRow(
    String text,
    TextEditingController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        header(text),
        const Spacer(),
        textField(controller),
      ],
    );
  }

  Row infoPassRow(
    String text,
    TextEditingController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        header(text),
        const Spacer(),
        textPassField(controller),
      ],
    );
  }

  textPassField(TextEditingController controller) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        alignment: Alignment.center,
        height: 7.h,
        width: 50.w,
        child: TextFormField(
          obscureText: !signUpController.passwordVisibility.value,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(signUpController.passwordVisibility.value == false
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded),
              onPressed: () {
                signUpController.passwordVisibility.value =
                    !signUpController.passwordVisibility.value;
              },
            ),
          ),
          maxLines: 1,
          controller: controller,
        ),
      );
    });
  }

  Container textField(TextEditingController controller) {
    return Container(
    
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      alignment: Alignment.center,
      height: 7.h,
      width: 50.w,
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        maxLines: 1,
        controller: controller,
      ),
    );
  }

  Text header(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14.sp),
    );
  }
}
