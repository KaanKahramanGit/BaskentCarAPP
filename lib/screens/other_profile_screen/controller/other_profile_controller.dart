import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OtherProfileController extends GetxController {
  String arguments = Get.arguments;

  TextEditingController commentController = TextEditingController();

  List<String> oldPosts = [];
  List<String> comments = [];

  int oldPostCounter = 0;
  int commentCounter = 0;

  Future<void> addComment() {
    return oldcomments.doc('$arguments').collection('comments').add({
      'date': DateFormat('dd.MM.yyyy').format(DateTime.now()),
      'message': commentController.text,
      'owner_name': 'Eylül Gümüş'
    });
  }

  Future getOldPosts() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$arguments')
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
        .doc('$arguments')
        .collection('old_posts');
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.size;
    oldPostCounter = totalEquals;
    return totalEquals;
  }

  Future getComments() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$arguments')
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
        .doc('$arguments')
        .collection('comments');
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.size;
    commentCounter = totalEquals;
    return totalEquals;
  }

  CollectionReference posts = FirebaseFirestore.instance.collection('users');

  CollectionReference oldcomments =
      FirebaseFirestore.instance.collection('users');

  @override
  void onInit() {
    oldPostCount();
    commentCount();
    super.onInit();
  }
}
