import 'package:achoo_api/app/data/provider/chat_message_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ChatMessageRepository {
  final ChatMessageProvider provider;

  ChatMessageRepository({required this.provider});

  getUser(id) {
    return provider.getUser(id);
  }

  postUser(Map data) {
    return provider.postUser(data);
  }

}