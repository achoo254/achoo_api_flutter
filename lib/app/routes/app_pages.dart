import 'package:achoo_api/app/modules/dashboard_module/dashboard_binding.dart';

import '../../app/modules/chat_message_module/chat_message_page.dart';
import '../../app/modules/chat_message_module/chat_message_bindings.dart';
import '../../app/modules/chat_message_module/chat_message_page.dart';
import '../../app/modules/chat_message_module/chat_message_bindings.dart';
import 'package:achoo_api/app/modules/api_module/add_new_view.dart';

import '../../app/modules/test_module/test_page.dart';
import '../../app/modules/test_module/test_bindings.dart';
import '../../app/modules/collection_module/collection_page.dart';
import '../../app/modules/collection_module/collection_bindings.dart';
import 'package:achoo_api/app/modules/dashboard_module/dashboard_view.dart';

import '../../app/modules/login_module/login_bindings.dart';
import '../../app/modules/login_module/login_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.ADD_NEW,
      page: () => AddNewView(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardView(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: Routes.COLLECTION,
      page: () => CollectionPage(),
      binding: CollectionBinding(),
    ),
    GetPage(
      name: Routes.TEST,
      page: () => testPage(),
      binding: testBinding(),
    ),
    GetPage(
      name: Routes.CHAT_MESSAGE,
      page: () => ChatMessagePage(),
      binding: ChatMessageBinding(),
    ),
    GetPage(
      name: Routes.CHAT_MESSAGE,
      page: () => ChatMessagePage(),
      binding: ChatMessageBinding(),
    ),
  ];
}
