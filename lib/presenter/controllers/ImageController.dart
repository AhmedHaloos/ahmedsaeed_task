


import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/datamodel/ResultApi.dart';

class ImageController extends GetxController{


  final image  = Rxn<XFile>();
  final imgsUrl = <String>[].obs;
  final imgsMetadata = <FullMetadata>[].obs;
  final prevToken = "".obs;
  final firstImgDownloaded = true.obs;
  final updateDelete = false.obs;

  void updateImage(XFile newImage){
    if(newImage == null){
      print("new image is null");

    }
    else {
      print("new image is not null");
    this.image.value = newImage;
    }
    update();
  }
  void updateImges(ResultApi resultApi){

    if(resultApi.status == ResultApi.success){
      imgsUrl.value = resultApi.data?["urls"];
      imgsMetadata.value = resultApi.data?["metadata"];
      prevToken.value =  resultApi.data?["page_token"];
    print("download image controller token = ${resultApi.data?["page_token"]}");
       update();
    }
    else {
      print("error in updating ui for controller");
    }
  }
  void deleteImageState(bool isDeleted){
    updateDelete.value = isDeleted;
    update();
  }
  /// update the state of the first image download
  void updateFirstImageLoadedImg(bool isLoaded){
    this.firstImgDownloaded.value = true;
    update();
  }

}