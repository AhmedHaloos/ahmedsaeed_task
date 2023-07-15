
import 'package:ahmedsaeedtask/model/backend/LoginBackend.dart';
import 'package:ahmedsaeedtask/model/datamodel/ResultApi.dart';
import 'package:ahmedsaeedtask/presenter/LoginPresenter.dart';
import 'package:ahmedsaeedtask/presenter/routes/ImageBinding.dart';
import 'package:ahmedsaeedtask/presenter/routes/LoginBinding.dart';
import 'package:ahmedsaeedtask/presenter/routes/RegisterBinding.dart';
import 'package:ahmedsaeedtask/view/ImageListScreen.dart';
import 'package:ahmedsaeedtask/view/ImageUploadScreen.dart';
import 'package:ahmedsaeedtask/view/LoginScreen.dart';
import 'package:ahmedsaeedtask/view/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';
bool isLoggedIn = false;
void main() async{
   await initFirebase();
   LoginBackend _loginBAckend = LoginBackend();
   _loginBAckend.checkUserLoggedIn((result){
     if(result.status == ResultApi.success){
       isLoggedIn = true;
     }
   });
  runApp(const MyApp());
}
/// i used MVP architecture for this small task, for bigger scale apps i usually use another architecture

 initFirebase()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen(),
      initialRoute: isLoggedIn ? "pickimg":"/login",
      getPages: [
        GetPage(name: "/login", page: ()=>LoginScreen(), binding: LoginBinding()),
        GetPage(name: "/register", page: ()=>RegisterScreen(), binding: RegisterBinding()),
        GetPage(name: "/pickimg", page: ()=>ImageUploadScreen(), binding: ImageBinding()),
        GetPage(name: "/imglist", page: ()=>ImageListScreen(), binding: ImageBinding()),
      ],
    );
  }

}