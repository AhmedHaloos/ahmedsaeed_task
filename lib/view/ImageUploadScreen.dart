import 'dart:io';

import 'package:ahmedsaeedtask/model/backend/FirebaseStoragebackend.dart';
import 'package:ahmedsaeedtask/model/datamodel/ResultApi.dart';
import 'package:ahmedsaeedtask/presenter/ImagePresenter.dart';
import 'package:ahmedsaeedtask/presenter/controllers/ImageController.dart';
import 'package:ahmedsaeedtask/view/ImageDisplayScreen.dart';
import 'package:ahmedsaeedtask/view/ImageListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../presenter/global/functions.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImageUploadScreenState();
  }
}

class ImageUploadScreenState extends State<ImageUploadScreen> {
  ImagePresenter? _imagePresenter;

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return GetBuilder(
        init: ImageController(),
        builder: (controller) {
          _imagePresenter = ImagePresenter(controller);
          return Scaffold(
              appBar: AppBar(
                title: Text("Upload photo"),
              ),
              body: Container(
                alignment: Alignment.center,
                child: ListView(children: [
                  Column(
                    textDirection: TextDirection.ltr,
                    children: [
                      SizedBox(
                        width: 54,
                        height: media.size.height * 0.2,
                      ),
                      Text(
                        "Pick Image to upload",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(
                        width: 54,
                        height: media.size.height * 0.1,
                      ),
                      ElevatedButton(
                        style: createElevatedButtonStyle(
                            width: media.size.width * 0.6),
                        onPressed: () {
                          pickImage();
                          if (controller.image.value != null) {
                            print(controller.image.value!.name);
                          }
                        },
                        child: Text("Pick Image"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child:
                        controller.image.value ==  null?
                        Text("No image selected ")
                            :
                        Image.file(
                          File(controller.image.value!.path),
                          width: media.size.width * .6,
                          height: media.size.height * .3,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      ElevatedButton(
                        style: createElevatedButtonStyle(
                            width: media.size.width * 0.6),
                        onPressed: () {
                          ///used backend directly
                          FirebaseStorageBackend _backend  = FirebaseStorageBackend();
                          if(controller.image.value != null){
                            print("image in imagePreseneter is not null");
                          _backend.uploadImage(
                              File(controller.image.value!.path), DateTime.now().toString(), (result){
                                handleUploadState(context, result);
                          });
                          }
                          else {
                            print("image is null in imagePresenetr");
                          }
                        },
                        child: Text("Upload Image"),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        style: createElevatedButtonStyle(
                            width: media.size.width * 0.6),
                        onPressed: () {
                         navigate(context,ImageListScreen() , false);
                        },
                        child: Text("Display Images"),
                      ),
                    ],
                  ),
                ]),
              ));
        });
  }

  ///this method responsible for picking image from device or cam
  void pickImage() {
    _imagePresenter!.selectImgSource(context, () {
      _imagePresenter!.pickImageFromCam((result) {
        if (result.status == ResultApi.success) {
          _imagePresenter!.image = result.data?["image"];
          _imagePresenter!.updateImage();
        }
      });
    }, () {
      _imagePresenter!.pickImage((result) {
        if (result.status == ResultApi.success) {
          print("picked image from gallery ${result.data?["image"]}");
          _imagePresenter!.image = result.data?["image"];
          _imagePresenter!.updateImage();
        }
      });
    });
  }

  ///handle upload state, either print error or navigate
  ///to the screen that display the uploaded image
  void handleUploadState(BuildContext context, ResultApi result){
    if(result.status == ResultApi.success){
      File image = result.data?["image"];
      DateTime createdTime = result.data?["created_time"];
      navigate(context, ImageDisplayScreen(image, createdTime), false);
    }
    else {
      print("error uploading the image");
    }
  }

}
