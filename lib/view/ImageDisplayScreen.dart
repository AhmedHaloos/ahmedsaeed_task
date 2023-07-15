import 'dart:io';
import 'package:ahmedsaeedtask/model/datamodel/ResultApi.dart';
import 'package:ahmedsaeedtask/presenter/ImagePresenter.dart';
import 'package:ahmedsaeedtask/presenter/controllers/ImageController.dart';
import 'package:ahmedsaeedtask/view/ImageUploadScreen.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presenter/global/functions.dart';
import '../model/backend/FirebaseStoragebackend.dart';

class ImageDisplayScreen extends StatelessWidget {
  File? _image;
  String? _imgName;
  DateTime _createTime;
  String? imgLoadingUrl;
  ImageDisplayScreen(this._image, this._createTime, [this.imgLoadingUrl]);
  ImagePresenter? _imagePresenter;

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    _imgName = path.basename(_image!.path);
    return Scaffold(
        appBar: AppBar(
          title: Text("display image"),
        ),
        body: GetBuilder<ImageController>(
          init: ImageController(),
          builder: (controller) {
            _imagePresenter = ImagePresenter(controller);
            if(controller.updateDelete.value){
              Navigator.pop(context);
            }
            return Container(
                    width: media.size.width,
                    child: ListView(
                      children: [
                        imgLoadingUrl == null?
                        Image.file(
                          _image!,
                          fit: BoxFit.fitWidth,
                        ):
                        Image.network(imgLoadingUrl!),
                        Text("image : ${path.basename(_image!.path)}"),
                        Text("created at : ${_createTime.toLocal()}"),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 30),
                          child: ElevatedButton(
                            style: createElevatedButtonStyle(
                                width: media.size.width * 0.4,
                                color: Colors.red),
                            onPressed: () {
                              /// i shortly used the backend class here directly,
                              /// as the structure of the app clear
                              // FirebaseStorageBackend _backend =
                              //     FirebaseStorageBackend();
                              _imagePresenter!.deleteImage(_imgName);

                            },
                            child: Text("Delete Image"),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ));
  }

}
