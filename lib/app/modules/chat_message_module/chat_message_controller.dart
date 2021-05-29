import 'dart:async';
import 'dart:convert';

import 'package:achoo_api/app/data/model/chat_message.dart';
import 'package:achoo_api/app/data/repository/chat_message_repository.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ChatMessageController extends GetxController {
  //Khởi tạo repo
  final ChatMessageRepository repository;

  //Khởi tạo hàm dựng
  ChatMessageController({required this.repository});

  //get data
  var _chatMessageList = [].obs;

  set chatMessageList(value) => _chatMessageList.value = value;

  // ignore: invalid_use_of_protected_member
  get chatMessageList => _chatMessageList.value;

  //Khởi tạo bool check kết quả realtime
  Timer? time;

  //Khởi tạo ghi log
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  //Khởi tạo form key
  final formKey = GlobalKey<FormState>();

  //Khởi tạo giá trị truyền đi
  final TextEditingController textEditingController = TextEditingController();

  //Khởi tạo firebase
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  listData(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      snapshot.data!.docs.forEach((element) {
        var response = element.data();
        Map<String, dynamic> data = Map();
        data.putIfAbsent('key', () => response);
        ChatMessage chatMessage = ChatMessage.fromJson(data['message']);
        chatMessageList.add(chatMessage);
      });
    }
  }

  void sendMessage(String message) async {
    DateTime datetime = DateTime.now();
    ChatMessage chatMessage = ChatMessage(
        usersId: GlobalVariables.users.id,
        message: message,
        createdAt: datetime);
    await firestore.collection("chat").add(chatMessage.toJson());
  }

  getData() {
    Stream<QuerySnapshot> _firebaseDb =
        FirebaseFirestore.instance.collection("chat").orderBy("createdAt", descending: true).snapshots();
    _firebaseDb.listen((event) {
      chatMessageList = event.docs;
    });
    return chatMessageList;
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
