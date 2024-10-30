import 'package:baskent_car_app/constants/app_paths.dart';
import 'package:baskent_car_app/screens/chat_detail_screen/view/chat_detail_screen.dart';
import 'package:baskent_car_app/screens/chat_screen/view/chat_screen.dart';
import 'package:baskent_car_app/screens/create_post_screen/view/create_post_screen.dart';
import 'package:baskent_car_app/screens/forgotten_password_screen/view/forgotten_password_screen.dart';
import 'package:baskent_car_app/screens/home_screen/view/home_screen.dart';
import 'package:baskent_car_app/screens/login_screen/view/login_screen.dart';
import 'package:baskent_car_app/screens/my_profile_screen/view/my_profile_screen.dart';
import 'package:baskent_car_app/screens/other_profile_screen/view/other_profile_screen.dart';
import 'package:baskent_car_app/screens/post_detail_screen/view/post_detail_screen.dart';
import 'package:baskent_car_app/screens/sign_up_screen/view/sign_up_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage<dynamic>> getPages = [
    GetPage(
      name: AppPaths.pathOfHomeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfLoginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfSignUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfForgottenPasswordScreen,
      page: () => ForgottenPasswordScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfCreatePostScreen,
      page: () => CreatePostScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfMyProfileScreen,
      page: () => MyProfileScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfPostDetailScreen,
      page: () => PostDetailScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfOtherProfileScreen,
      page: () => OtherProfileScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfChatScreen,
      page: () => ChatScreen(),
    ),
    GetPage(
      name: AppPaths.pathOfChatDetailScreen,
      page: () => ChatDetailScreen(),
    ),
  ];
}
