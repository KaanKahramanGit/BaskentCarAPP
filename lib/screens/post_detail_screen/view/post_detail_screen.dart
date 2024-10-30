import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/utilities/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Eylül İpek Gümüş",
                style: AppTextStyles.boldTextStyle,
              ),
              Text(
                "Başlangıç Noktası    -->    Varış Noktası",
                style: AppTextStyles.normalTextStyle,
              ),
              Row(
                children: [
                  Text(
                    "Yakıt Talebi: ",
                    style: AppTextStyles.normalTextStyle,
                  ),
                  SizedBox(width: 3.w),
                  Container(
                    height: 5.h,
                    width: 10.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.blackColor,
                      ),
                    ),
                    child: Text(
                      "20",
                      style: AppTextStyles.normalTextStyle,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Text("₺",
                      style: AppTextStyles.normalTextStyle
                          .copyWith(fontSize: 14.sp)),
                ],
              ),
              Text(
                "Yolcu Sayısı:  2",
                style: AppTextStyles.normalTextStyle,
              ),
              Text(
                "Yolculuk Başlangıç Saati: 08.30",
                style: AppTextStyles.normalTextStyle,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: AppColors.blackColor),
                    backgroundColor: AppColors.whiteColor,
                  ),
                  child: Text(
                    "Sürücünün profilini gör",
                    style: AppTextStyles.normalTextStyle
                        .copyWith(color: AppColors.blackColor),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: AppColors.blackColor),
                    backgroundColor: AppColors.whiteColor,
                  ),
                  child: Text(
                    "Mesaj Gönder",
                    style: AppTextStyles.normalTextStyle
                        .copyWith(color: AppColors.blackColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
