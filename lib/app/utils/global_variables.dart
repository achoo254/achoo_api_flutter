import 'dart:ui';

import 'package:achoo_api/app/data/model/users.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class GlobalVariables {
  //Info user login
  static const String USER_INFO_ID = "userInfoId";
  static const String USER_INFO_NAME = "userInfoName";
  static const String USER_INFO_EMAIL = "userInfoEmail";
  static const String USER_INFO_AVATAR = "userInfoAvatar";
  //Base Url API
  static const String BASE_URL = "https://60372b355435040017721b8d.mockapi.io";

  //Global
  static const String TEXT_LOGO = "Achoo API";
  static const String TEXT_DASHBOARD = "Dashboard";
  static const String TEXT_CATEGORIES = "Collection";
  static const String TEXT_SUBCRIES = "Best Api";
  static const String TEXT_KEY = "Key";
  static const String TEXT_VALUE = "Value";
  static const String EMPTY_VALUE = "Empty";
  static const String UNKNOWN_VALUE = "Unknown";
  //Khởi tạo đối tượng lưu trữ thông tin user
  static final dataStorage = GetStorage();
  static Users users = Users(id: '', createdAt: DateTime.now(), name: 'name', avatar: 'avatar', email: 'email', password: 'password');

  //Add new
  static const String ADD_NEW_TEXT_REQUEST = "REQUEST";
  static const String ADD_NEW_TEXT_RESPONSE = "RESPONSE";
  static const String ADD_NEW_TEXT_HISTORY = "HISTORY";
  static const String ADD_NEW_TEXT_REQUEST_URL = "Request Url";
  static const String ADD_NEW_TEXT_METHOD = "Method";
  static const String ADD_NEW_TEXT_BODY = "Body (JSON)";
  static const String ADD_NEW_TEXT_SELECT_METHOD = "Choose method";
  static const String ADD_NEW_TEXT_HEADER = "Add header";
  static const String ADD_NEW_TEXT_PARAMETER = "Add parameter";
  static const String ADD_NEW_TEXT_SEND_REQUEST_TO_COLLECTION = "Send request to collection";
  static const String ADD_NEW_TEXT_REQUEST_NAME = "Request name";
  static const String ADD_NEW_TEXT_REQUEST_USE_EXISTING_COLLECTION = "Use existing collection";
  static const String ADD_NEW_TEXT_CREATE_NEW_COLLECTION_HINT = "Or create new collection";

  //Login form
  static const String TEXT_EMAIL = "Email";
  static const String TEXT_EMAIL_HINT = "Enter email";
  static const String TEXT_PASSWORD = "Password";
  static const String TEXT_PASSWORD_HINT = "Enter password";
  static const String TEXT_FORGOT_PASSWORD = "Forgot password?";
  static const String TEXT_CLICK_HERE = "Click here";
  static const String TEXT_LOGIN = "LOGIN";
  static const String TEXT_REGISTER = "REGISTER";

  //Color
  static const String MAIN_COLOR = "#06294a";
  static const String SECOND_COLOR = "#055680";
  static const String THIRD_COLOR = "#5774b0";
  static const String UTILS_COLOR = "#2a5298";
  static const String LINE_COLOR = "#00eabe";
  static const Color LABEL_COLOR = Colors.white60;
  static const Color TEXT_COLOR = Colors.white;
  static const Color HINT_TEXT_COLOR = Colors.white70;
  static const Color DELETE_COLOR = Colors.redAccent;
  static const Color WARNING_COLOR = Colors.yellowAccent;

  //Button text
  static const String BUTTON_TEXT_SUBMIT = "Submit";
  static const String BUTTON_TEXT_CANCEL = "Cancel";
  static const String BUTTON_TEXT_DELETE = "Delete";
  static const String BUTTON_TEXT_SAVE = "Save";

  //Button size
  static const double BUTTON_HEIGHT_SIZE = 40;

  //Font size
  static const double LABEL_FIELD_SIZE = 20;
  static const double INPUT_FIELD_SIZE = 16;
  static const double TEXT_SIZE = 16;
  static const double HINT_TEXT_SIZE = 14;
}
