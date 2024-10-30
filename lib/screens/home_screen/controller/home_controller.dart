import 'package:baskent_car_app/constants/app_paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isEmailVerified = false.obs;
  RxBool emailLoadingStatue = false.obs;
  RxBool isloading = false.obs;

  Future logout() async {
    await checkVerify();
    await FirebaseAuth.instance.signOut();

    Get.offAllNamed(AppPaths.pathOfLoginScreen);
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }

  Future checkVerify() async {
    await FirebaseAuth.instance.currentUser!.reload();
    isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;
  }

  changeLoadingStatue(RxBool loadingStatue) {
    loadingStatue.value = !loadingStatue.value;
  }

  List<String> docsIDs = [];
  int count = 0;

  Future getComms() async {
    await FirebaseFirestore.instance.collection('posts').get().then(
          (snapshot) => snapshot.docs.forEach(
            (post) {
              print(post.id);
              docsIDs.add(post.reference.id);
            },
          ),
        );
  }

  Future totalLikes() async {
    var respectsQuery = await FirebaseFirestore.instance.collection('posts');
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.size;
    count = totalEquals;
    return totalEquals;
  }

  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  // Future<Object?> GetData() async {
  //   try {
  //     changeLoadingStatue(isloading);
  //     FirebaseDatabase database = FirebaseDatabase.instance;

  //     DatabaseReference ref = FirebaseDatabase.instance.ref("posts");

  //     DatabaseEvent event = await ref.once();

  //     return event.snapshot.value;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   } finally {
  //     changeLoadingStatue(isloading);
  //   }
  //   return null;
  // }

  @override
  void onInit() async {
    changeLoadingStatue(emailLoadingStatue);
    await FirebaseAuth.instance.currentUser!.reload();
    isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;
    changeLoadingStatue(emailLoadingStatue);

    super.onInit();
  }
}
