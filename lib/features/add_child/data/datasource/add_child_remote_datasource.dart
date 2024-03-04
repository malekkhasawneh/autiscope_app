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
      CollectionReference childrenCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('children');
      QuerySnapshot querySnapshot = await childrenCollection.get();
      List<ChildModel> children = [];
      for (var child in querySnapshot.docs) {
        Map<String, dynamic> json = child.data() as Map<String, dynamic>;
        children.add(ChildModel.formJson(json));
      }
      return children;
    } on Exception {
      throw ServerException();
    }
  }
}
