import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  List<String> oldPosts = [];
  List<String> comments = [];

  int oldPostCounter = 0;
  int commentCounter = 0;

  Future getOldPosts() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('Eylül İpek Gümüş')
        .collection('old_posts')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (oldPost) {
              print(oldPost.id);
              oldPosts.add(oldPost.reference.id);
            },
          ),
        );
  }

  Future oldPostCount() async {
    var respectsQuery = await FirebaseFirestore.instance
        .collection('users')
        .doc('Eylül İpek Gümüş')
        .collection('old_posts');
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.size;
    oldPostCounter = totalEquals;
    return totalEquals;
  }

  Future getComments() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('Eylül İpek Gümüş')
        .collection('comments')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (comment) {
              print(comment.id);
              comments.add(comment.reference.id);
            },
          ),
        );
  }

  Future commentCount() async {
    var respectsQuery = await FirebaseFirestore.instance
        .collection('users')
        .doc('Eylül İpek Gümüş')
        .collection('comments');
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.size;
    commentCounter = totalEquals;
    return totalEquals;
  }

  CollectionReference posts = FirebaseFirestore.instance
      .collection('users')
      .doc('Eylül İpek Gümüş')
      .collection('old_posts');

  CollectionReference oldcomments = FirebaseFirestore.instance
      .collection('users')
      .doc('Eylül İpek Gümüş')
      .collection('comments');

  @override
  void onInit() {
    oldPostCount();
    commentCount();
    super.onInit();
  }
}
