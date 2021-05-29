import 'package:achoo_api/app/modules/chat_message_module/chat_message_controller.dart';
import 'package:achoo_api/app/data/provider/chat_message_provider.dart';
import 'package:achoo_api/app/data/repository/chat_message_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ChatMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatMessageController(repository: ChatMessageRepository(provider: ChatMessageProvider())));
  }
}