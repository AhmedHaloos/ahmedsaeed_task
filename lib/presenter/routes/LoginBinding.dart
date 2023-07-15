


import 'package:ahmedsaeedtask/presenter/controllers/LoginController.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings{

  @override
  void dependencies() {
   Get.lazyPut<LoginController>(() => LoginController());
  }
}