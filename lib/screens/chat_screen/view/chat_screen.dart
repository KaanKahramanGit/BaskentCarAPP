import 'package:baskent_car_app/constants/app_paths.dart';
import 'package:baskent_car_app/screens/chat_screen/controller/chat_controller.dart';
import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/utilities/text_styles.dart';
import 'package:baskent_car_app/widgets/drawers/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();

  ChatController chatController = Get.put(ChatController());

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
              rideStatsList(),
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
          future: chatController.getChats(),
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: chatController.chatCounter,
              itemBuilder: (context, index) {
                return ListTile(
                  title: FutureBuilder<DocumentSnapshot>(
                    future: chatController.posts
                        .doc(chatController.chats[index])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppPaths.pathOfChatDetailScreen,
                                arguments:
                                    data['name'] + " " + data['surname']);
                          },
                          child: Container(
                              height: 12.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.blackColor,
                                      width: 0.5.w)),
                              child: Row(
                                children: [
                                  Icon(Icons.person, size: 20.sp),
                                  SizedBox(width: 3.w),
                                  Text(data['name']),
                                  SizedBox(width: 1.w),
                                  Text(data['surname']),
                                  Spacer(),
                                  Icon(Icons.arrow_right_rounded,
                                      size: 30.sp, color: AppColors.blackColor),
                                ],
                              )),
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

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 2, 0, 101),
      title: Text(
        "Mesajlar",
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
