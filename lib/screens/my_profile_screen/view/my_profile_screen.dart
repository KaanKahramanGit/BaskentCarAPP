import 'package:baskent_car_app/screens/my_profile_screen/controller/my_profile_controller.dart';
import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/utilities/text_styles.dart';
import 'package:baskent_car_app/widgets/drawers/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();

  MyProfileController myProfileController = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(),
        backgroundColor: AppColors.whiteColor,
        appBar: appBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileOwner(),
              SizedBox(height: 3.h),
              rideStatsHeader(),
              SizedBox(height: 3.h),
              listHeaderRow(),
              SizedBox(height: 1.h),
              rideStatsList(),
              SizedBox(height: 2.h),
              messagesHeader(),
              SizedBox(height: 2.h),
              commentList(),
            ],
          ),
        ),
      ),
    );
  }

  rideStatsList() {
    return SizedBox(
        width: Get.width,
        height: 30.h,
        child: FutureBuilder(
          future: myProfileController.getOldPosts(),
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: myProfileController.oldPostCounter,
              itemBuilder: (context, index) {
                return ListTile(
                  title: FutureBuilder<DocumentSnapshot>(
                    future: myProfileController.posts
                        .doc(myProfileController.oldPosts[index])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Container(
                            height: 12.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.blackColor, width: 0.5.w)),
                            child: Row(
                              children: [
                                Text(data['post_date']),
                                SizedBox(width: 1.w),
                                Text(data['post_time']),
                                SizedBox(width: 14.w),
                                SizedBox(
                                  height: 10.h,
                                  width: 30.w,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Text(data['post_guests'][index]);
                                    },
                                  ),
                                )
                              ],
                            ));
                      }
                      return Text("yükleniyor..");
                    },
                  ),
                );
              },
            );
          },
        ));
  }

  commentList() {
    return SizedBox(
        width: Get.width,
        height: 30.h,
        child: FutureBuilder(
          future: myProfileController.getComments(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: myProfileController.commentCounter,
              itemBuilder: (context, index) {
                return ListTile(
                  title: FutureBuilder<DocumentSnapshot>(
                    future: myProfileController.oldcomments
                        .doc(myProfileController.comments[index])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Container(
                          height: 12.h,
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.blackColor, width: 0.5.w)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(data['message']),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(data['date']),
                                  Text(data['owner_name']),
                                ],
                              )
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
        ));
  }

   listHeaderRow() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tarih",
            style: AppTextStyles.semiBoldTextStyle,
          ),
          Text(
            "Saat",
            style: AppTextStyles.semiBoldTextStyle,
          ),
          Text(
            "Ad Soyad                     ",
            style: AppTextStyles.semiBoldTextStyle,
          ),
        ],
      ),
    );
  }

  Text rideStatsHeader() {
    return Text(
      "Yolculuk Kayıtları",
      style: AppTextStyles.googleBoldstyle,
    );
  }

  Text messagesHeader() {
    return Text(
      "Gelen Yorumlar",
      style: AppTextStyles.googleBoldstyle,
    );
  }

  profileOwner() {
    return Text(
      "Eylül İpek GÜMÜŞ",
      style: AppTextStyles.googleBoldstyle.copyWith(fontSize: 14.sp),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 2, 0, 101),
      title: Text(
        "Profil",
        style: AppTextStyles.boldTextStyle.copyWith(
          color: AppColors.whiteColor,
          fontSize: 14.0.sp,
        ),
      ),
      leading: IconButton(
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
        icon: Icon(
          Icons.menu,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
