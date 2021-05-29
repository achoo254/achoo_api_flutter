import 'package:achoo_api/app/data/model/chat_message.dart';
import 'package:achoo_api/app/modules/chat_message_module/chat_message_controller.dart';
import 'package:achoo_api/app/theme/my_input_field.dart';
import 'package:achoo_api/app/theme/my_scaffold.dart';
import 'package:achoo_api/app/utils/global_function.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'chat_message_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ChatMessagePage extends GetView<ChatMessageController> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(body: bodyFunction(context), selected: 3);
  }

  bodyFunction(context) {
    return Column(
      children: [
        Expanded(child: chatMessage()),
        toolMessage(context),
      ],
    );
  }

  toolMessage(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, right: 5, left: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                HexColor(GlobalVariables.SECOND_COLOR),
                HexColor(GlobalVariables.THIRD_COLOR)
              ]),
        ),
        width: double.maxFinite,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Form(
                  key: controller.formKey,
                  child: MyInputField(
                    controller: controller.textEditingController,
                    validateMinLength: true,
                    multiLine: 1,
                    hintText: 'Send message...',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    Get.find<ChatMessageController>()
                        .sendMessage(controller.textEditingController.text);
                    controller.textEditingController.clear();
                    FocusScope.of(context).unfocus();
                    controller.formKey.currentState!.reset();
                    controller.update();
                  }
                },
                icon: Icon(Icons.send),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  chatMessage() {
    // return FutureBuilder(
    //   future: Get.find<ChatMessageController>().getData(),
    //   builder: (context, snapshot) {
    //     if (controller.chatMessageList.length > 0) {
    //       return Padding(
    //         padding:
    //         const EdgeInsets.only(top: 23.0, bottom: 10, left: 5, right: 5),
    //         child: ListView.separated(
    //           reverse: true,
    //           itemBuilder: (context, index) {
    //             return Row(
    //               crossAxisAlignment: CrossAxisAlignment.end,
    //               children: [
    //                 if (controller.chatMessageList[index].usersId ==
    //                     GlobalVariables.users.id)
    //                   Expanded(child: Container()),
    //                 if (controller.chatMessageList[index].usersId !=
    //                     GlobalVariables.users.id)
    //                   ClipRRect(
    //                       borderRadius: BorderRadius.circular(200),
    //                       child: FlutterLogo()),
    //                 if (controller.chatMessageList[index].usersId !=
    //                     GlobalVariables.users.id)
    //                   SizedBox(
    //                     width: 5,
    //                   ),
    //                 Column(
    //                   crossAxisAlignment:
    //                   (controller.chatMessageList[index].usersId ==
    //                       GlobalVariables.users.id)
    //                       ? CrossAxisAlignment.end
    //                       : CrossAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                         width: 170,
    //                         child: Text(
    //                           '${controller.chatMessageList[index].createdAt}',
    //                           style: TextStyle(color: Colors.white70),
    //                           textAlign:
    //                           (controller.chatMessageList[index].usersId ==
    //                               GlobalVariables.users.id)
    //                               ? TextAlign.right
    //                               : TextAlign.left,
    //                         )),
    //                     Container(
    //                         padding: EdgeInsets.all(3),
    //                         constraints: BoxConstraints(maxWidth: 170),
    //                         decoration: BoxDecoration(
    //                             color: Colors.white70,
    //                             borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(10),
    //                                 topRight: Radius.circular(10),
    //                                 bottomLeft: (controller
    //                                     .chatMessageList[index]
    //                                     .usersId ==
    //                                     GlobalVariables.users.id)
    //                                     ? Radius.circular(10)
    //                                     : Radius.circular(0),
    //                                 bottomRight: (controller
    //                                     .chatMessageList[index]
    //                                     .usersId ==
    //                                     GlobalVariables.users.id)
    //                                     ? Radius.circular(0)
    //                                     : Radius.circular(10))),
    //                         child: Text(
    //                             '${controller.chatMessageList[index].message}')),
    //                   ],
    //                 ),
    //               ],
    //             );
    //           },
    //           itemCount: controller.chatMessageList.length,
    //           separatorBuilder: (context, index) => Divider(),
    //         ),
    //       );
    //     } else {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
    return Obx((){
      if(controller.chatMessageList.length > 0){
        return Padding(
          padding:
          const EdgeInsets.only(top: 23.0, bottom: 10, left: 5, right: 5),
          child: ListView.separated(
            reverse: true,
            itemBuilder: (context, index) {
              ChatMessage chatMessage = ChatMessage.fromJson(controller.chatMessageList[index].data());
              String dateTime = GlobalFunction.getFormatedDateWithTime(chatMessage.createdAt.toString());
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (chatMessage.usersId ==
                      GlobalVariables.users.id)
                    Expanded(child: Container()),
                  if (chatMessage.usersId !=
                      GlobalVariables.users.id)
                    ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: FlutterLogo()),
                  if (chatMessage.usersId !=
                      GlobalVariables.users.id)
                    SizedBox(
                      width: 5,
                    ),
                  Column(
                    crossAxisAlignment:
                    (chatMessage.usersId ==
                        GlobalVariables.users.id)
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 170,
                          child: Text(
                            '$dateTime',
                            style: TextStyle(color: Colors.white70),
                            textAlign:
                            (chatMessage.usersId ==
                                GlobalVariables.users.id)
                                ? TextAlign.right
                                : TextAlign.left,
                          )),
                      Container(
                          padding: EdgeInsets.all(15),
                          constraints: BoxConstraints(maxWidth: 170),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: (chatMessage.usersId ==
                                      GlobalVariables.users.id)
                                      ? Radius.circular(15)
                                      : Radius.circular(0),
                                  bottomRight: (chatMessage.usersId ==
                                      GlobalVariables.users.id)
                                      ? Radius.circular(0)
                                      : Radius.circular(15))),
                          child: Text(
                              '${chatMessage.message}')),
                    ],
                  ),
                ],
              );
            },
            itemCount: controller.chatMessageList.length,
            separatorBuilder: (context, index) => Divider(),
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
