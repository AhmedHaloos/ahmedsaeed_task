import 'dart:io';

import 'package:ahmedsaeedtask/model/backend/FirebaseStoragebackend.dart';
import 'package:ahmedsaeedtask/model/datamodel/ResultApi.dart';
import 'package:ahmedsaeedtask/presenter/ImagePresenter.dart';
import 'package:ahmedsaeedtask/presenter/controllers/ImageController.dart';
import 'package:ahmedsaeedtask/view/ImageDisplayScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presenter/global/functions.dart';


class ImageListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ImageListScreenState();
  }
}

class ImageListScreenState extends State<ImageListScreen> {
  List<Reference> imgsMetaData = [];
  ImagePresenter? _imagePresenter;

  @override
  void initState() {

    ImageController controller = Get.find<ImageController>();
    _imagePresenter = ImagePresenter(controller);
    _imagePresenter!.downloadImgs("");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("All Images"),
      ),
      body: GetBuilder(
          builder: (ImageController controller) {
            _imagePresenter = ImagePresenter(controller);
              return Stack(
                children: [
                  Positioned(
                    top: 15,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                      child:
                      Center(
                        child: SizedBox(
                          width: media.size.width,
                          height: media.size.height * .8,
                          child: GridView.count(
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            children: controller.imgsUrl.value.asMap().entries.map((entry) {
                              print(entry.value);
                              return
                                GestureDetector(
                                onTap: () {
                                  // print(controller.imgsMetadata.toList()[entry.key].timeCreated);
                                  File _image = File(controller.imgsMetadata.toList()[entry.key].fullPath);
                                  DateTime? _createTime = controller.imgsMetadata.toList()[entry.key].timeCreated;
                                  navigate(
                                      context,
                                      ImageDisplayScreen(_image, _createTime!, entry.value)
                                      , false);
                                },
                                child: Image.network(entry.value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: ElevatedButton(
                            style: createElevatedButtonStyle(
                                width: media.size.width * 0.4, color: Colors.red),
                            onPressed: () {
                               _imagePresenter?.downloadImgs(controller.prevToken.value);
                              print("token from the list screen : ${controller.prevToken.value}");
                              // print("prev clicked");
                            },
                            child: Text("Next"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );}
    ),
    );
  }
}