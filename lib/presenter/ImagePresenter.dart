


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/backend/FirebaseStoragebackend.dart';
import '../model/datamodel/ResultApi.dart';
import 'controllers/ImageController.dart';

class ImagePresenter{

  XFile? image ;
  ImageController? _imageController;
  FirebaseStorageBackend? _backend;
  List<Map<String, dynamic>> imgsData = [];
  ImagePresenter(this._imageController){
    if(_imageController ==  null){
      throw  Exception("_imageController can not be null");
    }
    _backend = FirebaseStorageBackend();
  }


  ///update the image preview after picking the pimage
  void updateImage(){
    if(this.image != null){
      _imageController!.updateImage(this.image!);
    }
    else {
      print("uploaded image form presenter is null");
    }
  }
  ///pick multi image from gallery
  void pickImage(Function(ResultApi) callback){
    ImagePicker imagePicker = ImagePicker();
    // imagePicker.pickImage(source: ImageSource.camera);
    imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      requestFullMetadata: true
    )
        .then((images){
      ResultApi result  = ResultApi(ResultApi.success, {
        "image" : images,
      }, "");
      if(images != null) {
        print("picked img path : ${images.path}");
        callback(result);
      }
    });
  }
  /// pick image from camera
  void pickImageFromCam(Function(ResultApi) callback){
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      requestFullMetadata: true,
    )
        .then((image){
      if(image != null){
        callback(ResultApi(ResultApi.success, {
          "image" : image,
        }, ""));
      }
    });
  }
  /// use the dialog to select either from camera or from gallery
  void selectImgSource(BuildContext context, Function camCallback, Function galleryCallback){

    showDialog(context: context,
        builder: (context)=>AlertDialog(
          title: Text("Select Photo Source"),
          content: Text("select camera or gallery"),
          actions: [
            TextButton(onPressed: (){
              camCallback();
              Navigator.of(context).pop();
            }, child: Text("Camera")),
            TextButton(onPressed: (){
              galleryCallback();
              Navigator.of(context).pop();
            }, child: Text("Gallery"))
          ],
        )
    );
  }

  ///delete image from db
void deleteImage(_imgName){
  _backend!.deleteImage(_imgName!, (result) {
    if (result.status == ResultApi.success) {
      print("image deleted");
      _imageController!.deleteImageState(true);
    }
  });
}

///download image based on the prev token
void downloadImgs(String? _prevToken)async{

  print("download image presenter token = ${_prevToken}");
    _backend!.downloadPageImages("images",_prevToken,  (result){
      if(result.status == ResultApi.success){
      _imageController?.updateImges(result);
      }
      else {
        print("error in downloading images from firebase storage");
      }
    });
}

}