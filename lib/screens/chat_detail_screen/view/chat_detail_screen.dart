import 'package:baskent_car_app/screens/chat_detail_screen/controller/chat_detail_controller.dart';
import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/utilities/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChatDetailScreen extends StatelessWidget {
  ChatDetailScreen({super.key});

  ChatDetailController chatDetailController = Get.put(ChatDetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rideStatsList(),
              Container(
                width: Get.width,
                height: 18.h,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black54)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 10.h,
                      width: 70.w,
                      child: TextField(
                        controller: chatDetailController.messageController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black))),
                      ),
                    ),
                    Container(
                      height: 17.h,
                      width: 15.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[200],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          chatDetailController.addComment();
                          chatDetailController.messageController.text = "";
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  rideStatsList() {
    return Container(
        width: Get.width,
        height: 70.h,
        child: FutureBuilder(
          future: chatDetailController.getChats(),
          builder: (context, snapshot) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: chatDetailController.chatCounter,
              itemBuilder: (context, index) {
                return Container(
                  height: 10.h,
                  width: 60.w,
                  child: FutureBuilder<DocumentSnapshot>(
                    future: chatDetailController.posts
                        .doc(chatDetailController.arguments)
                        .collection('chat_detail')
                        .doc(chatDetailController.chats[index])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Row(
                          mainAxisAlignment:
                              data['sender'] != "Eylül İpek Gümüş"
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 12.h,
                              width: 70.w,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 1.h),
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 2.w),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      data['sender'] != "Eylül İpek Gümüş"
                                          ? BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10))
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                  color: data['sender'] == "Eylül İpek Gümüş"
                                      ? Colors.blue[300]
                                      : Colors.green[300]),
                              child: GestureDetector(
                                onTap: () {
                                  debugPrint(Timestamp.now().toString());
                                },
                                child: Text(data['message']),
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
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
        chatDetailController.arguments,
        style: AppTextStyles.boldTextStyle.copyWith(
          color: AppColors.whiteColor,
          fontSize: 14.0.sp,
        ),
      ),
    );
  }
}
