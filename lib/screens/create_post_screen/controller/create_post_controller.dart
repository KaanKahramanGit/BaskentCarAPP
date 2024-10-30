import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {
  RxString selectedValue = "1".obs;
  final List<String> passengerCount = ['1', '2', '3', '4'];
  Rx<DateTime> dateTime = DateTime.now().obs;

  Rx<TimeOfDay> timeOfDay = TimeOfDay.now().obs;
}
