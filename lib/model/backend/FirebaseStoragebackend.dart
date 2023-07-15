import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../datamodel/ResultApi.dart';

class FirebaseStorageBackend {
  final storageRef = FirebaseStorage.instance.ref();

  void uploadImage(File file, String uploadDate, Function(ResultApi) callback) {
    final imgStorage = storageRef.child("images/${path.basename(file.path)}");
    SettableMetadata metadata = SettableMetadata(customMetadata: {
      "name": path.basename(file.path),
      "upload_date": uploadDate,
    });
    final task = imgStorage.putFile(file, metadata);
    task.snapshotEvents.listen((event) {
      if (event.state == TaskState.success) {
        print("firebase storage backend ${event.state.name}");
        callback(ResultApi(ResultApi.success,
            {"image": file, "created_time": DateTime.timestamp()}, ""));
      } else if (event.state == TaskState.error) {
        print("firebase storage backend ${event.state.name}");
        callback(ResultApi(ResultApi.failed, {}, "error uploading the file"));
      }
    });
  }

  /// downloads images from firebase storage
  void downloadImages(String imagsePath, Function(ResultApi) callback) {
    storageRef.child(imagsePath).listAll().then((resList) async {
      List<String> imgDownloadUrls = [];
      List<FullMetadata> imgMetaDate = [];
      for (Reference item in resList.items) {
        imgDownloadUrls.add(await item.getDownloadURL());
        imgMetaDate.add(await item.getMetadata());
      }
      callback(ResultApi(
          ResultApi.success,
          {
            "urls": imgDownloadUrls,
            "metadata": imgMetaDate,
          },
          ""));
    });
  }

  ///delete image
  void deleteImage(String imgName, Function(ResultApi) callback) {
    storageRef.child("images/$imgName").delete().then((res) {
      callback(ResultApi(ResultApi.success, {}, ""));
      print("deleted");
    }).catchError((error) {
      callback(ResultApi(ResultApi.failed, {}, ""));
    });
  }

  ///download page of images
  void downloadPageImages(
      String imagsePath, String? _prevToken, Function(ResultApi) callback) {
    print("page token before from backend :  ${_prevToken}");
    storageRef
        .child(imagsePath)
        .list(ListOptions(
          maxResults: 10,
          pageToken: _prevToken,
        ))
        .then((resList) async {
      List<String> imgDownloadUrls = [];
      List<FullMetadata> imgMetaDate = [];
      for (Reference item in resList.items) {
        imgDownloadUrls.add(await item.getDownloadURL());
        imgMetaDate.add(await item.getMetadata());
      }
      print("page token after from backend :  ${resList.nextPageToken}");
      callback(ResultApi(
          ResultApi.success,
          {
            "urls": imgDownloadUrls,
            "metadata": imgMetaDate,
            "page_token": resList.nextPageToken??"",
          },
          ""));
    });
  }
}
