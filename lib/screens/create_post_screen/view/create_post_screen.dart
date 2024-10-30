import 'package:baskent_car_app/screens/create_post_screen/controller/create_post_controller.dart';
import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/utilities/text_styles.dart';
import 'package:baskent_car_app/widgets/drawers/drawer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();

  CreatePostController createPostController = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar(),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Nereden",
                          style: AppTextStyles.normalTextStyle,
                        ),
                        SizedBox(height: 1.h),
                        SizedBox(
                          height: 5.h,
                          width: 20.w,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.sp,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 20.sp,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Nereye",
                          style: AppTextStyles.normalTextStyle,
                        ),
                        SizedBox(height: 1.h),
                        SizedBox(
                          height: 5.h,
                          width: 20.w,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.sp,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                gasDemand(),
                SizedBox(height: 2.h),
                passengerCount(),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tarih",
                      style: AppTextStyles.normalTextStyle,
                    ),
                    SizedBox(width: 2.w),
                    Obx(
                      () {
                        return GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            height: 5.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.blackColor, width: 1.sp),
                            ),
                            child: Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(createPostController.dateTime.value),
                            ),
                          ),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: createPostController.dateTime.value,
                              firstDate: createPostController.dateTime.value,
                              lastDate: DateTime(DateTime.now().year + 2),
                            );

                            if (picked != null &&
                                picked != createPostController.dateTime.value) {
                              createPostController.dateTime.value = picked;
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Başlangıç Saati",
                      style: AppTextStyles.normalTextStyle,
                    ),
                    SizedBox(width: 5.w),
                    Obx(
                      () {
                        return GestureDetector(
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: createPostController.timeOfDay.value,
                            );
                            if (picked != null &&
                                picked !=
                                    createPostController.timeOfDay.value) {
                              createPostController.timeOfDay.value = picked;
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 5.h,
                                width: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AppColors.blackColor,
                                    width: 1.sp,
                                  ),
                                ),
                                child: Text(createPostController
                                    .timeOfDay.value.hour
                                    .toString()),
                              ),
                              SizedBox(width: 2.w),
                              Container(
                                alignment: Alignment.center,
                                height: 5.h,
                                width: 10.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AppColors.blackColor,
                                    width: 1.sp,
                                  ),
                                ),
                                child: Text(createPostController
                                    .timeOfDay.value.minute
                                    .toString()
                                    .padLeft(2, '0')),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onDoubleTap: () {},
                  child: Container(
                    height: 5.h,
                    width: 25.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.blackColor,
                        width: 1.sp,
                      ),
                    ),
                    child: Text(
                      "Kaydet",
                      style: AppTextStyles.normalTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row passengerCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Yolcu Sayısı",
          style: AppTextStyles.normalTextStyle,
        ),
        Obx(
          () {
            return DropdownButton2(
              items: createPostController.passengerCount
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: createPostController.selectedValue.value,
              onChanged: (value) {
                createPostController.selectedValue.value = value as String;
              },
            );
          },
        )
      ],
    );
  }

  Row gasDemand() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Yakıt Talebi: ",
          style: AppTextStyles.normalTextStyle,
        ),
        SizedBox(width: 5.w),
        Row(
          children: [
            SizedBox(
              height: 5.h,
              width: 10.w,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              "₺",
              style: AppTextStyles.normalTextStyle.copyWith(fontSize: 16.sp),
            )
          ],
        )
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "İlan Oluştur",
        style: AppTextStyles.boldTextStyle.copyWith(
          color: AppColors.blackColor,
          fontSize: 14.0.sp,
        ),
      ),
      leading: IconButton(
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
        icon: Icon(
          Icons.menu,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
