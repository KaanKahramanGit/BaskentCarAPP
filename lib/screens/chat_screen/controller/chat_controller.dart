import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  List<String> chats = [];

  int chatCounter = 0;

  Future getChats() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('Eylül İpek Gümüş')
        .collection('chat')
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
        .collection('chat');
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
