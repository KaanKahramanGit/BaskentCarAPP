import 'package:baskent_car_app/constants/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/images/Deneme.jpg',
              fit: BoxFit.fill,
            ),
          ),
          ListTile(
            title: Text("Ana Sayfa"),
            onTap: () {
              Get.offNamed(AppPaths.pathOfHomeScreen);
            },
          ),
          ListTile(
            title: Text("Mesajlar"),
            onTap: () {
              Get.offNamed(AppPaths.pathOfChatScreen);
            },
          ),
          ListTile(
            title: Text("Profil"),
            onTap: () {
              Get.offNamed(AppPaths.pathOfMyProfileScreen);
            },
          ),
          ListTile(
            title: Text("İlan Oluştur"),
            onTap: () {
              Get.offNamed(AppPaths.pathOfCreatePostScreen);
            },
          ),
        ],
      ),
    );
  }
}
