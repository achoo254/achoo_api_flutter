import 'package:achoo_api/app/data/dto/history_dto.dart';
import 'package:achoo_api/app/data/model/collection.dart';
import 'package:achoo_api/app/modules/api_module/bloc/collection/collection_bloc.dart';
import 'package:achoo_api/app/modules/api_module/bloc/history/history_bloc.dart';
import 'package:achoo_api/app/theme/background.dart';
import 'package:achoo_api/app/theme/error_exception.dart';
import 'package:achoo_api/app/theme/loading_process.dart';
import 'package:achoo_api/app/theme/my_button_submit.dart';
import 'package:achoo_api/app/theme/my_dropdown_field.dart';
import 'package:achoo_api/app/theme/my_input_field.dart';
import 'package:achoo_api/app/theme/my_scaffold.dart';
import 'package:achoo_api/app/theme/my_text_title.dart';
import 'package:achoo_api/app/utils/global_function.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:achoo_api/app/utils/json_view_background.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hexcolor/hexcolor.dart';

import 'bloc/header/header_bloc.dart';
import 'bloc/method/method_bloc.dart';
import 'bloc/parameter/parameter_bloc.dart';
import 'bloc/request_response/request_api_bloc.dart';

class AddNewView extends StatefulWidget {
  AddNewView({Key? key}) : super(key: key);

  @override
  _AddNewViewState createState() => _AddNewViewState();
}

class _AddNewViewState extends State<AddNewView>
    with SingleTickerProviderStateMixin {
  //Tạo đối tượng bloc
  final MethodBloc methodBloc = MethodBloc();
  final RequestApiBloc requestApiBloc = RequestApiBloc();
  final HeaderBloc headerBloc = HeaderBloc();
  final ParameterBloc parameterBloc = ParameterBloc();
  final CollectionBloc collectionBloc = CollectionBloc();
  final HistoryBloc historyBloc = HistoryBloc();

  //Load method
  _loadMethod() async {
    methodBloc.add(GetMethodEvent());
  }

  //Load history
  _loadHistory() async {
    historyBloc.add(ShowHistoryEvent());
  }

  @override
  void initState() {
    //Init data method
    _loadMethod();
    _loadHistory();
    requestApiBloc.tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    methodBloc.dispose();
    requestApiBloc.dispose();
    headerBloc.dispose();
    parameterBloc.dispose();
    collectionBloc.dispose();
    historyBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return MyScaffold(body: bodyFunction(),selected: 0,);
  }

  bodyFunction(){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Background(
            body: Container(
              child: TabBar(
                controller: requestApiBloc.tabController,
                tabs: [
                  Tab(
                    text: GlobalVariables.ADD_NEW_TEXT_REQUEST,
                  ),
                  Tab(
                    text: GlobalVariables.ADD_NEW_TEXT_RESPONSE,
                  ),
                  Tab(
                    text: GlobalVariables.ADD_NEW_TEXT_HISTORY,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: requestApiBloc.tabController,
          children: [
            Background(
              body: tabViewRequest(),
            ),
            Background(
              body: tabViewResponse(),
            ),
            Background(
              body: tabViewHistory(),
            ),
          ],
        ),
      ),
    );
  }

  tabViewRequest() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: requestApiBloc.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextTitle(title: GlobalVariables.ADD_NEW_TEXT_REQUEST_URL),
                MyInputField(
                  controller: requestApiBloc.requestInputController,
                  validateMinLength: false,
                  validateRequire: true,
                  multiLine: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    MyTextTitle(
                      title: GlobalVariables.ADD_NEW_TEXT_METHOD,
                    ),
                    Expanded(child: Container()),
                    StreamBuilder<MethodState>(
                      stream: methodBloc.methodStream,
                      builder: (context, state) {
                        if (state.data is MethodLoaded) {
                          if (state.data!.props.isEmpty) {
                            return ErrorException(
                              error: GlobalVariables.EMPTY_VALUE,
                            );
                          }
                          if (requestApiBloc.methodSelected == null) {
                            requestApiBloc.methodSelected =
                                state.data!.props[0];
                          }
                          return MyDropdownField(
                            width: 150,
                            itemList: state.data!.props
                                .map((item) => DropdownMenuItem(
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                          color: GlobalVariables.TEXT_COLOR),
                                    ),
                                    value: item))
                                .toList(),
                            onChanged: (value) {
                              requestApiBloc.methodSelected = value;
                            },
                            objectSeleted: requestApiBloc.methodSelected,
                          );
                        } else if (state is MethodError) {
                          return ErrorException(
                            error: state.error.toString(),
                          );
                        } else if (state is MethodLoading) {
                          return LoadingProcess();
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MyButtonSubmit(
                        title: GlobalVariables.ADD_NEW_TEXT_HEADER,
                        function: () {
                          headerBloc.add(AddHeaderEvent());
                        },
                      ),
                      showListHeader(),
                      SizedBox(
                        height: 10,
                      ),
                      MyButtonSubmit(
                        title: GlobalVariables.ADD_NEW_TEXT_PARAMETER,
                        function: () {
                          parameterBloc.add(AddParameterEvent());
                        },
                      ),
                      showListParameter(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextTitle(title: GlobalVariables.ADD_NEW_TEXT_BODY),
                MyInputField(
                  controller: requestApiBloc.bodyInputController,
                  multiLine: null,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: MyButtonSubmit(
                        title: GlobalVariables.BUTTON_TEXT_SAVE,
                        function: () {
                          //Load dialog
                          AwesomeDialog(
                            context: context,
                            dismissOnTouchOutside: false,
                            animType: AnimType.SCALE,
                            dialogType: DialogType.INFO,
                            dialogBackgroundColor:
                                HexColor(GlobalVariables.SECOND_COLOR),
                            body: showDialogConfirm(),
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              if (requestApiBloc.formKey.currentState!
                                  .validate()) {
                                requestApiBloc.add(SaveApiEvent(
                                    requestUrl: requestApiBloc
                                        .requestInputController.text,
                                    methodId: requestApiBloc.methodSelected.id,
                                    body:
                                        requestApiBloc.bodyInputController.text,
                                    requestName: requestApiBloc
                                        .nameRequestInputController.text,
                                    collectionId: requestApiBloc
                                                .collectionSelected ==
                                            null
                                        ? '0'
                                        : requestApiBloc.collectionSelected.id,
                                    collectionName: requestApiBloc
                                        .createCollectionInputController.text,
                                    headerList: headerBloc.headerList,
                                    parameterList:
                                        parameterBloc.parameterList));
                              }
                            },
                          )..show();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MyButtonSubmit(
                        title: GlobalVariables.BUTTON_TEXT_SUBMIT,
                        function: () {
                          if (requestApiBloc.formKey.currentState!.validate()) {
                            requestApiBloc.tabController.animateTo(1);
                            requestApiBloc.add(RequestApiSendEvent(
                                requestUrl:
                                    requestApiBloc.requestInputController.text,
                                methodName: requestApiBloc.methodSelected.name,
                                headerList: headerBloc.headerList,
                                parameterList: parameterBloc.parameterList,
                                body: requestApiBloc.bodyInputController.text));
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  tabViewResponse() {
    return StreamBuilder<RequestApiState>(
      stream: requestApiBloc.requestApiStream,
      builder: (context, snapshot) {
        if (snapshot.data is RequestApiLoaded) {
          if (snapshot.data!.props.isEmpty) {
            return ErrorException(
              error: GlobalVariables.EMPTY_VALUE,
            );
          }
          //Chuyển kiểu dữ liệu trả về sang Map để hiển thị
          Map<String, dynamic> _convertMap = Map();
          _convertMap.putIfAbsent("data", () => snapshot.data!.props);
          return Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: SingleChildScrollView(
                    child: JsonViewerWidget(_convertMap, notRoot: false)),
              ),
            ),
          );
        } else if (snapshot.data is RequestApiLoading) {
          return LoadingProcess();
        } else if (snapshot.data is RequestApiError) {
          return ErrorException(
            error: snapshot.error.toString(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  tabViewHistory() {
    return StreamBuilder<HistoryState>(
      stream: historyBloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.data!.props.length == 0) {
          return Center(
            child: Text(GlobalVariables.EMPTY_VALUE),
          );
        } else if (snapshot.data!.props.length > 0 &&
            snapshot.data is ShowHistoryLoaded) {
          return Expanded(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: GroupedListView<HistoryDto, String>(
                elements: snapshot.data!.props,
                groupBy: (element) => GlobalFunction.getFormatedDate(element.api.createdAt.toString()),
                groupSeparatorBuilder: (String groupByValue) => MyTextTitle(
                    title: groupByValue),
                indexedItemBuilder: (context, HistoryDto element, index) {
                  return Card(
                    color: HexColor(GlobalVariables.UTILS_COLOR),
                    elevation: 5.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: MyTextTitle(
                            title: element.method.name,
                            textStyle: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: MyTextTitle(
                          title: element.api.name,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyTextTitle(
                              title: element.api.url,
                              textOverflow: TextOverflow.ellipsis,
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: GlobalVariables.TEXT_COLOR,
                              ),
                            ),
                            MyTextTitle(
                              title: GlobalFunction.getFormatedDateWithTime(
                                  element.api.createdAt.toString()),
                              textStyle: TextStyle(
                                  fontSize: 15,
                                  color: GlobalVariables.TEXT_COLOR),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          color: GlobalVariables.TEXT_COLOR,
                          onPressed: () {
                            historyBloc.add(DeleteHistoryEvent(id: element.usersApiId, historyDto: element));
                          },
                          icon: Icon(Icons.restore_from_trash_outlined),
                        ),
                      ),
                    ),
                  );
                },
                itemComparator: (item1, item2) =>
                    item1.api.name.compareTo(item2.api.name),
                // optionaloptional
                floatingHeader: true,
                // optional
                order: GroupedListOrder.DESC, // optional
              ),
            ),
          ));
        } else if (snapshot.data is ShowHistoryLoading) {
          return LoadingProcess();
        } else if (snapshot.data is ShowHistoryError) {
          return ErrorException(error: snapshot.error.toString());
        }
        return Container();
      },
    );
  }

  showListHeader() {
    return StreamBuilder<HeaderState>(
      stream: headerBloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.data!.props.length > 0 &&
            snapshot.data is AddHeaderStateLoaded) {
          return Container(
            height: 110,
            child: ListView.separated(
              separatorBuilder: (_, __) => SizedBox(
                height: 8,
              ),
              itemBuilder: (context, index) {
                //Khởi tạo controller
                TextEditingController key = TextEditingController();
                requestApiBloc.keyHeaderController.add(key);
                TextEditingController value = TextEditingController();
                requestApiBloc.valueHeaderController.add(value);

                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: MyInputField(
                        controller: requestApiBloc.keyHeaderController[index],
                        hintText: GlobalVariables.TEXT_KEY,
                        onChanged: (key) {
                          snapshot.data!.props[index]!.key = key;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: MyInputField(
                        controller: requestApiBloc.valueHeaderController[index],
                        hintText: GlobalVariables.TEXT_VALUE,
                        onChanged: (value) {
                          snapshot.data!.props[index]!.value = value;
                        },
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.bottomRight,
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: GlobalVariables.DELETE_COLOR,
                      ),
                      onPressed: () {
                        requestApiBloc.keyHeaderController.removeAt(index);
                        requestApiBloc.valueHeaderController.removeAt(index);
                        headerBloc.add(RemoveHeaderEvent(index: index));
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
              itemCount: snapshot.data!.props.length,
            ),
          );
        }
        return Container();
      },
    );
  }

  showListParameter() {
    return StreamBuilder<ParameterState>(
      stream: parameterBloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.data!.props.length > 0 &&
            snapshot.data is AddParameterStateLoaded) {
          return Container(
            height: 110,
            child: ListView.separated(
              separatorBuilder: (_, __) => SizedBox(
                height: 8,
              ),
              itemBuilder: (context, index) {
                //Khởi tạo controller
                TextEditingController key = TextEditingController();
                requestApiBloc.keyParameterController.add(key);
                TextEditingController value = TextEditingController();
                requestApiBloc.valueParameterController.add(value);

                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller:
                            requestApiBloc.keyParameterController[index],
                        onChanged: (key) {
                          snapshot.data!.props[index]!.key = key;
                        },
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        HexColor(GlobalVariables.LINE_COLOR))),
                            hintText: GlobalVariables.TEXT_KEY,
                            hintStyle:
                                TextStyle(color: GlobalVariables.TEXT_COLOR)),
                        style: TextStyle(
                            color: GlobalVariables.TEXT_COLOR,
                            fontSize: GlobalVariables.INPUT_FIELD_SIZE),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller:
                            requestApiBloc.valueParameterController[index],
                        onChanged: (value) {
                          snapshot.data!.props[index]!.value = value;
                        },
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        HexColor(GlobalVariables.LINE_COLOR))),
                            hintText: GlobalVariables.TEXT_VALUE,
                            hintStyle:
                                TextStyle(color: GlobalVariables.TEXT_COLOR)),
                        style: TextStyle(
                            color: GlobalVariables.TEXT_COLOR,
                            fontSize: GlobalVariables.INPUT_FIELD_SIZE),
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.bottomRight,
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: GlobalVariables.DELETE_COLOR,
                      ),
                      onPressed: () {
                        requestApiBloc.keyParameterController.removeAt(index);
                        requestApiBloc.valueParameterController.removeAt(index);
                        parameterBloc.add(RemoveParameterEvent(index: index));
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
              itemCount: snapshot.data!.props.length,
            ),
          );
        }
        return Container();
      },
    );
  }

  showDialogConfirm() {
    collectionBloc.add(GetCollectionEvent());
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: MyTextTitle(
              title: GlobalVariables.ADD_NEW_TEXT_SEND_REQUEST_TO_COLLECTION,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MyTextTitle(
            title: GlobalVariables.ADD_NEW_TEXT_REQUEST_NAME,
            textStyle: TextStyle(color: GlobalVariables.LABEL_COLOR),
          ),
          MyInputField(
            validateRequire: true,
            validateMaxLength: true,
            validateMinLength: true,
            controller: requestApiBloc.nameRequestInputController,
          ),
          SizedBox(
            height: 20,
          ),
          MyTextTitle(
            title: GlobalVariables.ADD_NEW_TEXT_REQUEST_USE_EXISTING_COLLECTION,
            textStyle: TextStyle(color: GlobalVariables.LABEL_COLOR),
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<CollectionState>(
            stream: collectionBloc.stream,
            builder: (context, state) {
              if (state.data is CollectionLoaded) {
                if (state.data!.props.isEmpty) {
                  return ErrorException(
                    error: GlobalVariables.EMPTY_VALUE,
                  );
                }
                if (requestApiBloc.collectionSelected == null) {
                  requestApiBloc.collectionSelected = state.data!.props[0];
                }
                return MyDropdownField(
                  itemList: state.data!.props
                      .map((Collection item) => DropdownMenuItem<Collection>(
                          child: Text(
                            item.name,
                            style: TextStyle(color: GlobalVariables.TEXT_COLOR),
                          ),
                          value: item))
                      .toList(),
                  onChanged: (value) {
                    requestApiBloc.collectionSelected = value;
                  },
                );
              } else if (state.data is CollectionError) {
                return ErrorException(
                  error: state.error.toString(),
                );
              } else if (state.data is CollectionLoading) {
                return LoadingProcess();
              } else {
                return Container();
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          MyInputField(
            hintText: GlobalVariables.ADD_NEW_TEXT_CREATE_NEW_COLLECTION_HINT,
            validateRequire: true,
            validateMaxLength: true,
            validateMinLength: true,
            controller: requestApiBloc.createCollectionInputController,
          ),
        ],
      ),
    );
  }
}
