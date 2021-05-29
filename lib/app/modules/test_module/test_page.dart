import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:achoo_api/app/modules/test_module/test_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class testPage extends GetWidget<testController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
