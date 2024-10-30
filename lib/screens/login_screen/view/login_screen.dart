import 'package:baskent_car_app/constants/app_paths.dart';
import 'package:baskent_car_app/screens/home_screen/view/home_screen.dart';
import 'package:baskent_car_app/screens/login_screen/controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});

//   LoginController loginController = Get.put(LoginController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: const Color.fromARGB(255, 92, 163, 230),
//           body: StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 debugPrint("Giriş başarılı");

//                 return HomeScreen();
//               } else {
//                 debugPrint("Giriş Başarısız");

//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       imgContainer(),
//                       mailRow(),
//                       passwordRow(),
//                       switchButton(),
//                       authButtons(),
//                     ],
//                   ),
//                 );
//               }
//             },
//           )),
//     );
//   }

//   Row authButtons() {
//     return Row(
//       //bela butonlar
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color.fromARGB(255, 24, 10, 177),
//             textStyle: const TextStyle(
//                 color: Color.fromARGB(255, 199, 55, 55),
//                 fontSize: 20,
//                 fontFamily: 'font'),
//           ),
//           onPressed: () {
//             loginController.login();
//           },
//           child: const Text('Giriş'),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color.fromARGB(255, 16, 3, 108),
//             textStyle: const TextStyle(
//                 color: Color.fromARGB(255, 144, 28, 28),
//                 fontSize: 20,
//                 fontFamily: 'font'),
//           ),
//           onPressed: () {
//             Get.toNamed(AppPaths.pathOfSignUpScreen);
//           },
//           child: const Text('Hesap oluştur'),
//         ),
//       ],
//     );
//   }

//   Obx switchButton() {
//     return Obx(
//       () {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(loginController.switchButton.value == false
//                 ? "Yolcu"
//                 : "Sürücü"),
//             Switch(
//               value: loginController.switchButton.value,
//               onChanged: ((value) {
//                 loginController.switchButton.value = value;
//               }),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Row passwordRow() {
//     return Row(
//       //şifre ve text alanı
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Text(
//           "Şifre",
//           style: TextStyle(
//               fontSize: 15.sp,
//               fontFamily: 'font',
//               color: const Color.fromARGB(255, 0, 0, 0)),
//         ),
//         Text(
//           "Şlllll",
//           style: TextStyle(
//             fontSize: 15.sp,
//             fontFamily: 'font',
//             color: const Color.fromARGB(255, 92, 163, 230),
//           ),
//         ),
//         SizedBox(
//           width: 50.w,
//           height: 10.h,
//           child: TextField(
//             controller: loginController.passwordController,
//           ),
//         ),
//       ],
//     );
//   }

//   Container imgContainer() => Container(
//         //ekranda alan böldük resim için
//         height: 50.h,
//         width: 100.w,
//         alignment: Alignment.center,
//         decoration:
//             const BoxDecoration(color: Color.fromARGB(255, 92, 163, 230)),

//         child: Image.asset('assets/images/Resim1.png'),

//       );

//   Row mailRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Öğrenci Maili",
//           style: TextStyle(
//               fontSize: 15.sp,
//               fontFamily: 'font',
//               color: const Color.fromARGB(255, 0, 0, 0)),
//         ),
//         SizedBox(
//           width: 5.w,
//         ),
//         SizedBox(
//           height: 10.h,
//           width: 50.w,
//           child: TextField(
//             controller: loginController.mailController,
//           ),
//         ),
//       ],
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 3, 25, 50),
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                debugPrint("Giriş başarılı");

                return HomeScreen();
              } else {
                debugPrint("Giriş Başarısız");

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      imgContainer(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 52.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7.h,
                            ),
                            textOkulNo(),
                            distanceBox(),
                            textPassword(),
                            forgottenPasswordRow(),
                            distanceBox(),
                            //buttonsBox(),
                            distanceBox(),
                            buttonsRow(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }

  Row forgottenPasswordRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            Get.toNamed(
                AppPaths.pathOfForgottenPasswordScreen); //...............................
          },
          child: Text("Şifremi Unuttum"),
        ),
      ],
    );
  }

  SizedBox textOkulNo() {
    return SizedBox(
      width: 50.w,
      height: 8.h,
      child: TextField(
        controller: loginController.mailController,
        decoration: InputDecoration(
            hintText: "Okul Numarası",
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black))),
      ),
    );
  }

  SizedBox textPassword() {
    return SizedBox(
      width: 50.w,
      height: 8.h,
      child: TextField(
        controller: loginController.passwordController,
        decoration: InputDecoration(
          hintText: "Şifre",
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Row buttonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        authButtons(),
      ],
    );
  }

  // SizedBox buttonsBox() {
  //   return SizedBox(
  //     width: 30.w,
  //     height: 2.h,
  //     child: switchButton(),
  //   );
  // }

  SizedBox distanceBox() {
    return SizedBox(
      height: 2.h,
    );
  }

  Row authButtons() {
    return Row(
      //bela butonlar
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 24, 10, 177),
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 199, 55, 55),
                fontSize: 20,
                fontFamily: 'font'),
          ),
          onPressed: () {
            loginController.login();
          },
          child: const Text('Giriş'),
        ),
        SizedBox(
          width: 5.w,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 16, 3, 108),
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 144, 28, 28),
                fontSize: 20,
                fontFamily: 'font'),
          ),
          onPressed: () {
            Get.toNamed(AppPaths.pathOfSignUpScreen);
          },
          child: const Text('Hesap oluştur'),
        ),
      ],
    );
  }

  // Obx switchButton() {
  //   return Obx(
  //     () {
  //       return Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Text(loginController.switchButton.value == false
  //               ? "Yolcu"
  //               : "Sürücü"),
  //           Switch(
  //             value: loginController.switchButton.value,
  //             onChanged: ((value) {
  //               loginController.switchButton.value = value;
  //             }),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Container imgContainer() => Container(
        //ekranda alan böldük resim için
        height: 260.0,
        width: 450.0,
        //alignment: Alignment.center,

        decoration: const BoxDecoration(color: Color.fromARGB(255, 158, 0, 0)),

        child: Image.asset(
          'assets/images/Deneme.jpg',
          fit: BoxFit.fill,
        ),
      );
}
