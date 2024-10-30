import 'package:baskent_car_app/utilities/colors.dart';
import 'package:baskent_car_app/utilities/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  final double height;
  final double width;
  final String text;
  final Color backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: AppColors.blackColor,
            width: 1.5.sp,
          ),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          text,
          style: AppTextStyles.normalTextStyle.copyWith(
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
