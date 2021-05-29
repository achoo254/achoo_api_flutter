import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/model/users.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/global_variables.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if(GlobalVariables.dataStorage.read('users') != null){
      GlobalVariables.users = Users.fromJson(GlobalVariables.dataStorage.read('users'));
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Achoo API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: GlobalVariables.users.id.isNotEmpty ? Routes.LOGIN : Routes.LOGIN,
      getPages: AppPages.pages,
    );
  }
}
