import 'dart:developer';

import 'package:autiscope_app/features/signup/domain/usecase/sign_up_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  static SignUpCubit get(BuildContext context) => BlocProvider.of(context);

  SignUpCubit({required this.signUpUseCase}) : super(SignUpInitial());

  final SignUpUseCase signUpUseCase;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool _check = false;

  bool get getCheck => _check;

  set setCheck(bool value) {
    emit(SetAndGetLoading());
    _check = value;
    emit(SetAndGetLoaded());
  }

  Future<void> registerNewUser() async {
    emit(SignUpLoading());
    try {
      final response = await signUpUseCase(SignUpUseCaseParams(
          email: email.text.trim(),
          password: password.text.trim(),
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim()));
      response.fold((failure) => emit(SignUpError(error: failure.failure)),
          (res) {
        emit(SignUpLoaded(isSignUp: res));
      });
    } catch (error) {
      emit(SignUpError(error: error.toString()));
    }
  }

  bool validateControllers() {
    log('=================================== first ${firstName.text}');
    return firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty &&
        email.text.contains('@') &&
        password.text.length > 6 &&
        password.text == confirmPassword.text;
  }
}
