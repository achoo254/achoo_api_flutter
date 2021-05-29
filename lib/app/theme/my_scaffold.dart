import 'package:achoo_api/app/routes/app_pages.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'background.dart';
import 'logo.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final int selected;

  MyScaffold({required this.body, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
          onTap: () {
            //Ẩn bàn phím nếu chạm vào nơi khác bất kỳ
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child: Stack(
            children: [
              Background(body: Container()),
              Column(
                children: [
                  selected != 2
                      ? SizedBox()
                      : SizedBox(
                    height: 25,
                  ),
                  selected != 2
                      ? SizedBox()
                      : Logo(GlobalVariables.TEXT_DASHBOARD),
                  selected != 2
                      ? SizedBox()
                      : SizedBox(
                    height: 5,
                  ),
                  Expanded(child: Container(child: body)),
                ],
              ),
            ],
          )),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: HexColor(GlobalVariables.UTILS_COLOR),
        items: [
          TabItem(icon: Icons.api_outlined, title: 'Add'),
          TabItem(icon: Icons.collections, title: 'Collection'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.mark_chat_unread, title: 'Chat'),
        ],
        initialActiveIndex: selected,
        onTap: (index) {
          if(index == 2 && index != selected){
            Get.offAndToNamed(Routes.DASHBOARD);
          }
          if(index == 1 && index != selected){
            Get.offAndToNamed(Routes.COLLECTION);
          }
          if(index == 0 && index != selected){
            Get.offAndToNamed(Routes.ADD_NEW);
          }
          if(index == 3 && index != selected){
            Get.offAndToNamed(Routes.CHAT_MESSAGE);
          }
        },
      ),
    );
  }
}
