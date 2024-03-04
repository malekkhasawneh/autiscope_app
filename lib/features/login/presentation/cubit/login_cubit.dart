import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/login/domain/usecase/get_user_info_usecase.dart';
import 'package:autiscope_app/features/login/domain/usecase/login_usecase.dart';
import 'package:autiscope_app/features/login/domain/usecase/set_is_login.dart';
import 'package:autiscope_app/features/login/domain/usecase/set_user_info_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  LoginCubit({
    required this.loginUseCase,
    required this.setUserInfoUseCase,
    required this.getUserInfoUseCase,
    required this.setIsLoginUseCase,
  }) : super(LoginInitial());

  final LoginUseCase loginUseCase;
  final SetUserInfoUseCase setUserInfoUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final SetIsLoginUseCase setIsLoginUseCase;

  String userId = '';

  bool _check = false;

  bool get getCheck => _check;

  set setCheck(bool value) {
    emit(SetAndGetLoading());
    _check = value;
    emit(SetAndGetLoaded());
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login() async {
    emit(LoginLoading());
    try {
      final response = await loginUseCase(
        LoginUseCaseParams(email: email.text, password: password.text),
      );
      response.fold(
        (failure) => emit(LoginError(failure: failure.failure)),
        (userInfo) async {
          userId = userInfo.uid;
          await setUserInfo(user: userInfo);
          emit(
            LoginLoaded(userInfo: userInfo),
          );
        },
      );
    } catch (error) {
      emit(LoginError(failure: error.toString()));
    }
  }

  Future<void> setUserInfo({required User user}) async {
    emit(LoginLoading());
    try {
      final response =
          await setUserInfoUseCase(SetUserInfoUseCaseParams(user: user));
      response.fold((failure) => emit(LoginError(failure: failure.failure)),
          (success) => emit(SetAndGetLoaded()));
    } catch (error) {
      emit(LoginError(failure: error.toString()));
    }
  }

  Future<void> getUserInfo() async {
    emit(LoginLoading());
    try {
      final response = await getUserInfoUseCase(NoParams());
      response.fold(
        (failure) => emit(LoginError(failure: failure.failure)),
        (userId) {
          this.userId = userId;
          emit(
            SetAndGetLoaded(),
          );
        },
      );
    } catch (error) {
      emit(LoginError(failure: error.toString()));
    }
  }

  Future<void> setIsLogin() async {
    emit(LoginLoading());
    try {
      final response = await setIsLoginUseCase(NoParams());
      response.fold((failure) => emit(LoginError(failure: failure.failure)),
          (success) => emit(SetAndGetLoaded()));
    } catch (error) {
      emit(LoginError(failure: error.toString()));
    }
  }

  bool validateFields() {
    return email.text.isNotEmpty && password.text.isNotEmpty;
  }
}
