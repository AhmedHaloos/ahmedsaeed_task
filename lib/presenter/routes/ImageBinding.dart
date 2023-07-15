



import 'package:ahmedsaeedtask/presenter/controllers/ImageController.dart';
import 'package:get/get.dart';

class ImageBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ImageController>(() => ImageController() );
  }
}