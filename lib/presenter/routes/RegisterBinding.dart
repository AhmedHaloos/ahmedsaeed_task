



import 'package:ahmedsaeedtask/presenter/controllers/RegisterController.dart';
import 'package:get/get.dart';

class RegisterBinding implements Bindings{

  @override
  void dependencies() {
   Get.lazyPut<RegisterController>(() => RegisterController());
  }

}