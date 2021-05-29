import 'package:achoo_api/app/modules/collection_module/collection_controller.dart';
import 'package:achoo_api/app/theme/my_scaffold.dart';
import 'package:achoo_api/app/theme/my_text_title.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CollectionPage extends GetView<CollectionController> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(body: bodyFunction(), selected: 1);
  }

  bodyFunction() {
    return controller.obx(
      (state) {
        return ListView.separated(
          itemCount: controller.collectionDtoList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container();
          },
          itemBuilder: (BuildContext context, int index) {
            return ExpandableNotifier(
                child: ScrollOnExpand(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    ExpandablePanel(
                      theme: ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToExpand: true,
                        tapBodyToCollapse: true,
                        hasIcon: false,
                      ),
                      header: Container(
                        color: HexColor(GlobalVariables.MAIN_COLOR),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              ExpandableIcon(
                                theme: const ExpandableThemeData(
                                  expandIcon: Icons.folder,
                                  collapseIcon: Icons.folder_open_outlined,
                                  iconColor: Colors.white,
                                  iconSize: 28.0,
                                  iconPadding: EdgeInsets.only(right: 5),
                                  hasIcon: true,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //title
                                          MyTextTitle(
                                            title: controller
                                                .collectionDtoList[index]
                                                .collection
                                                .name,
                                          ),
                                          //subtitle
                                          MyTextTitle(
                                            title: controller
                                                .collectionDtoList[index]
                                                .collection
                                                .details,
                                            customSize: 12,
                                            textOverflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                            onTap: () async {
                                              await controller.deleteCollection(
                                                  controller.collectionDtoList[
                                                      index]);
                                            },
                                            child: Icon(
                                              Icons.restore_from_trash_outlined,
                                              color: Colors.white,
                                            )))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      collapsed: Container(),
                      expanded: buildList(index),
                    ),
                  ],
                ),
              ),
            ));
          },
        );
      },
      onLoading: Center(
        child: CircularProgressIndicator(),
      ),
      onEmpty: Container(),
    );
  }

  buildList(int index) {
    return FutureBuilder(
      future: controller.getDetailCollection(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (controller.collectionDtoList[index].api.length > 0) {
          return SingleChildScrollView(
            child: Container(
              color: HexColor(GlobalVariables.THIRD_COLOR),
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: controller.collectionDtoList[index].api.length,
                  itemBuilder: (context, indexApi) {
                    return MyTextTitle(
                        title: controller.collectionDtoList[index].api[indexApi].name);
                  },
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
