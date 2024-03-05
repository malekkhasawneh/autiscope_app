import 'dart:developer';

import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRemoteDataSource {
  Future<bool> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName});
}

class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  @override
  Future<bool> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String userId = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'firstName': firstName,
          'lastName': lastName,
        });
        CollectionReference registeredEmails =
            FirebaseFirestore.instance.collection('registeredEmails');
        await registeredEmails.add({
          'email': email,
        });
        return true;
      } catch (e) {
        log('=================================== log error ${e.toString()}');
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }
}
