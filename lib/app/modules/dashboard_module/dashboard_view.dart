import 'package:achoo_api/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:achoo_api/app/theme/my_scaffold.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class DashboardView extends GetView<DashBoardController>{
  @override
  Widget build(BuildContext context) {
    return MyScaffold(body: bodyFunction(), selected: 2);
  }

  bodyFunction() {
    return SingleChildScrollView(
      child: SizedBox(
        child: Container(
          padding: EdgeInsets.only(left: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  GlobalVariables.TEXT_CATEGORIES,
                  style: TextStyle(
                      color: GlobalVariables.LABEL_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: GlobalVariables.LABEL_FIELD_SIZE),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<DashBoardController>(
                  builder: (controller) {
                    return Container(
                      height: 200,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: DashBoardController.to.collectionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    HexColor(GlobalVariables.SECOND_COLOR),
                                    HexColor(GlobalVariables.THIRD_COLOR)
                                  ]),
                            ),
                            child: Center(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: FlutterLogo()),
                                title: Text(
                                  DashBoardController.to.collectionList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: GlobalVariables.TEXT_COLOR,
                                      fontSize: GlobalVariables.TEXT_SIZE),
                                ),
                                subtitle: Text(
                                  DashBoardController.to.collectionList[index].details,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: GlobalVariables.HINT_TEXT_COLOR,
                                      fontSize: GlobalVariables.HINT_TEXT_SIZE),
                                ),
                                trailing: VerticalDivider(
                                  width: 20,
                                  thickness: 3,
                                  color: HexColor(GlobalVariables.LINE_COLOR),
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.5,
                          // Tỉ lệ chiều-ngang/chiều-rộng của một item trong grid, ở đây width = 1.6 * height
                          crossAxisCount: 2,
                          // Số item trên một hàng ngang
                          crossAxisSpacing: 10,
                          // Khoảng cách giữa các item trong hàng ngang
                          mainAxisSpacing:
                              10, // Khoảng cách giữa các hàng (giữa các item trong cột dọc)
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  GlobalVariables.TEXT_SUBCRIES,
                  style: TextStyle(
                      color: GlobalVariables.LABEL_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: GlobalVariables.LABEL_FIELD_SIZE),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<DashBoardController>(
                  builder: (controller) => Container(
                    height: 200,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: DashBoardController.to.apiList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: HexColor(GlobalVariables.SECOND_COLOR)),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white),
                                  height: 130,
                                  child: FlutterLogo(),
                                  width: double.maxFinite,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0, top: 5.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DashBoardController.to.apiList[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: GlobalVariables.TEXT_COLOR,
                                          fontSize: GlobalVariables.TEXT_SIZE,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0, top: 5.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "subcribe ${DashBoardController.to.apiList[index].subcribe}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: GlobalVariables.HINT_TEXT_COLOR,
                                          fontSize:
                                              GlobalVariables.HINT_TEXT_SIZE),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.5,
                        // Tỉ lệ chiều-ngang/chiều-rộng của một item trong grid, ở đây width = 1.6 * height
                        crossAxisCount: 1,
                        // Số item trên một hàng ngang
                        crossAxisSpacing: 10,
                        // Khoảng cách giữa các item trong hàng ngang
                        mainAxisSpacing:
                            10, // Khoảng cách giữa các hàng (giữa các item trong cột dọc)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
