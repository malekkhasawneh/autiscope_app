import 'dart:developer';
import 'dart:io';

import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/resources/contants.dart';
import 'package:autiscope_app/features/add_child/data/model/child_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

abstract class AddChildRemoteDataSource {
  Future<bool> addChild(
      {required String userId,
      required String name,
      required String nickName,
      required String age});

  Future<List<ChildModel>> getChildren({required String userId});

  Future<void> downloadVideo({required String fileName});
}

class AddChildRemoteDataSourceImpl implements AddChildRemoteDataSource {
  @override
  Future<bool> addChild(
      {required String userId,
      required String name,
      required String nickName,
      required String age}) async {
    try {
      CollectionReference childrenCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('children');
      await childrenCollection.add({
        'name': name,
        'nickname': nickName,
        'age': age,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ChildModel>> getChildren({required String userId}) async {
    try {
      List<ChildModel> childModels = [];

      try {
        QuerySnapshot<Map<String, dynamic>> childrenSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('children')
                .get();
        for (var childDoc in childrenSnapshot.docs) {
          log('==================================== childDoc ${childDoc.data()}');
          ChildModel childModel = ChildModel.fromJson(childDoc.data());
          childModels.add(childModel);
        }
      } catch (e) {
        log('Error retrieving child models: $e');
        // Handle error as needed
      }

      return childModels;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<void> downloadVideo({required String fileName}) async {
    try {
      Reference reference =
          FirebaseStorage.instance.ref().child(fileName);
      String downloadUrl = await reference.getDownloadURL();
      Directory appDocDir = await getTemporaryDirectory();
      String filePath = '${appDocDir.path}/$fileName';
      File file = File(filePath);
      if (!await file.exists()) {
        log(
            '=========================== Download Started');
        await Dio().download(downloadUrl, filePath).whenComplete(() => log(
            '=========================== The video downloaded successfully'));
      } else {
        log('=========================== The video already exist');
      }
    } on Exception {
      throw ServerException();
    }
  }
}
