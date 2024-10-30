import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  String arguments = Get.arguments;

  TextEditingController messageController = TextEditingController();

  RxBool messageLoadingStatue = false.obs;

  List<String> chats = [];

  int chatCounter = 0;

  Future<void> addComment() {
    return posts.doc('$arguments').collection('chat_detail').add({
      'date': Timestamp.now(),
      'message': messageController.text,
      'sender': 'Eylül İpek Gümüş'
    });
  }

  Future getChats() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('Eylül İpek Gümüş')
        .collection('chat')
        .doc('$arguments')
        .collection('chat_detail')
        .orderBy('date', descending: false)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (chat) {
              print(chat.id);
              chats.add(chat.reference.id);
            },
          ),
        );
  }

  Future chatCount() async {
    var respectsQuery = await FirebaseFirestore.instance
        .collection('users')
        .doc('Eylül İpek Gümüş')
        .collection('chat')
        .doc('$arguments')
        .collection('chat_detail')
        .orderBy('date', descending: false);
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.size;
    chatCounter = totalEquals;
    return totalEquals;
  }

  CollectionReference posts = FirebaseFirestore.instance
      .collection('users')
      .doc('Eylül İpek Gümüş')
      .collection('chat');

  @override
  void onInit() {
    chatCount();
    super.onInit();
  }
}
