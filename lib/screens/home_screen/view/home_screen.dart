import 'package:baskent_car_app/constants/app_paths.dart';
import 'package:baskent_car_app/screens/home_screen/controller/home_controller.dart';
import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/utilities/text_styles.dart';
import 'package:baskent_car_app/widgets/buttons/custom_elevated_button.dart';
import 'package:baskent_car_app/widgets/drawers/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Ana Sayfa",
            style: AppTextStyles.boldTextStyle.copyWith(
              color: AppColors.blackColor,
              fontSize: 14.0.sp,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  homeController.logout();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: AppColors.blackColor,
                  size: 25.sp,
                ))
          ],
          leading: Obx(
            () {
              return homeController.isEmailVerified.value == false
                  ? SizedBox()
                  : IconButton(
                      onPressed: () => scaffoldKey.currentState?.openDrawer(),
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.blackColor,
                      ),
                    );
            },
          )),
      drawer: Obx(
        () {
          return homeController.isEmailVerified.value == false
              ? SizedBox()
              : AppDrawer();
        },
      ),
      body: Obx(
        () {
          return homeController.emailLoadingStatue.value == true
              ? Center(child: CircularProgressIndicator())
              : homeController.isEmailVerified.value == true
                  ? homeScreen()
                  : verifyEmailScreen();
        },
      ),
    );
  }

  Container verifyEmailScreen() {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lütfen mailinizi doğrulayınız.",
            style: AppTextStyles.normalTextStyle,
          ),
          SizedBox(height: 2.h),
          CustomElevatedButton(
            height: 5.h,
            width: 30.w,
            text: "Yenile",
            backgroundColor: AppColors.whiteColor,
            onPressed: () {
              
              homeController.logout();
            },
          )
        ],
      ),
    );
  }

  homeScreen() {
    homeController.totalLikes();
    return FutureBuilder(
      future: homeController.getComms(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: homeController.count,
          itemBuilder: (context, index) {
            return ListTile(
              title: FutureBuilder<DocumentSnapshot>(
                future: homeController.posts
                    .doc(homeController.docsIDs[index])
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      height: 15.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.blackColor, width: 0.5.w)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(AppPaths.pathOfOtherProfileScreen,
                                      arguments: data['host_name'] +
                                          " " +
                                          data['host_surname']);
                                },
                                child: Text(
                                  data['host_name'] +
                                      " " +
                                      data['host_surname'],
                                  style: AppTextStyles.boldTextStyle,
                                ),
                              ),
                              Text(
                                data['post_from'] + " --> " + data['post_to'],
                                style: AppTextStyles.boldTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                data['post_date'],
                                style: AppTextStyles.boldTextStyle,
                              ),
                              Text(
                                data['post_day'],
                                style: AppTextStyles.boldTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return Text("yükleniyor..");
                },
              ),
            );
          },
        );
      },
    );
  }
}
