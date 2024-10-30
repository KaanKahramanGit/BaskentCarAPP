import 'package:baskent_car_app/screens/other_profile_screen/controller/other_profile_controller.dart';
import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/utilities/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OtherProfileScreen extends StatelessWidget {
  OtherProfileScreen({super.key});

  OtherProfileController otherProfileController =
      Get.put(OtherProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: appBar(),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileOwner(),
                SizedBox(height: 2.h),
                rideStatsHeader(),
                SizedBox(height: 2.h),
                listHeaderRow(),
                SizedBox(height: 1.h),
                rideStatsList(),
                SizedBox(height: 1.h),
                messagesHeader(),
                SizedBox(height: 1.h),
                commentList(),
              ],
            ),
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
          future: otherProfileController.getOldPosts(),
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: otherProfileController.oldPostCounter,
              itemBuilder: (context, index) {
                return ListTile(
                  title: FutureBuilder<DocumentSnapshot>(
                    future: otherProfileController.posts
                        .doc(otherProfileController.arguments)
                        .collection('old_posts')
                        .doc(otherProfileController.oldPosts[index])
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
          future: otherProfileController.getComments(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: otherProfileController.commentCounter,
              itemBuilder: (context, index) {
                return ListTile(
                  title: FutureBuilder<DocumentSnapshot>(
                    future: otherProfileController.oldcomments
                        .doc(otherProfileController.arguments)
                        .collection('comments')
                        .doc(otherProfileController.comments[index])
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
      padding: EdgeInsets.symmetric(horizontal: 3.w),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          otherProfileController.arguments,
          style: AppTextStyles.googleBoldstyle.copyWith(fontSize: 14.sp),
        ),
        ElevatedButton(
          onPressed: () {
            Get.defaultDialog(
              barrierDismissible: false,
              title: 'Yorum Yap',
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      otherProfileController.arguments +
                          " kullanıcısı için yorumunuzu yazınız.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 1.h),
                    TextField(
                      controller: otherProfileController.commentController,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("İPTAL")),
                        ElevatedButton(
                            onPressed: () {
                              otherProfileController.addComment();
                              Get.back();
                              Duration(seconds: 2);
                              otherProfileController.onInit();
                            },
                            child: Text("TAMAM"))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          child: Text('Yorum Yap'),
        ),
      ],
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
    );
  }
}
