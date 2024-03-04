import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRemoteDataSource {
  Future<User> login({required String email, required String password});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<User> login({required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } on Exception {
      throw ServerException();
    }
  }
}
