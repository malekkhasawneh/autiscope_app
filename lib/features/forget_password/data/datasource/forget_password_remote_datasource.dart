import 'dart:developer';

import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<bool> resetPassword({required String email});
}

class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSource {
  @override
  Future<bool> resetPassword({required String email}) async {
    try {
      List<String> emails = [];
      QuerySnapshot<Map<String, dynamic>> emailsSnapshot =
          await FirebaseFirestore.instance.collection('registeredEmails').get();
      for (var email in emailsSnapshot.docs) {
        log('==================================== childDoc ${email.data()}');
        emails.add(email.data()['email']);
      }
      if (emails.contains(email)) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        return true;
      } else {
        return false;
      }
    } on Exception {
      throw ServerException();
    }
  }
}
