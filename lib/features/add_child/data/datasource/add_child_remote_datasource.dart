import 'dart:developer';

import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/features/add_child/data/model/child_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AddChildRemoteDataSource {
  Future<bool> addChild(
      {required String userId,
      required String name,
      required String nickName,
      required String age});

  Future<List<ChildModel>> getChildren({required String userId});
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
}
