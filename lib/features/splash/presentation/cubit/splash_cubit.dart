import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/splash/domain/usecase/get_is_first_time_usecase.dart';
import 'package:autiscope_app/features/splash/domain/usecase/is_login_usecase.dart';
import 'package:autiscope_app/features/splash/domain/usecase/set_is_first_time_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  SplashCubit({
    required this.isLoginUseCase,
    required this.setIsFirstTimeUseCase,
    required this.getIsFirstTimeUseCase,
  }) : super(SplashInitial());

  final IsLoginUseCase isLoginUseCase;
  final GetIsFirstTimeUseCase getIsFirstTimeUseCase;
  final SetIsFirstTimeUseCase setIsFirstTimeUseCase;

  bool _isTipsChecked = false;

  bool get getIsTipsChecked => _isTipsChecked;

  set setIsTipsChecked(bool value) {
    emit(SetAndGetLoading());
    _isTipsChecked = value;
    emit(SetAndGetLoaded());
  }

  bool isLogin = false;
  bool isFirstTime = false;

  Future<void> isUserLogin() async {
    emit(SplashLoading());
    try {
      final response = await isLoginUseCase(NoParams());
      response.fold((failure) => emit(SplashError(error: failure.failure)),
          (isLogin) {
        this.isLogin = isLogin;
        emit(SplashLoaded());
      });
    } catch (error) {
      emit(SplashError(error: error.toString()));
    }
  }

  Future<void> getIsFirstTime() async {
    emit(SplashLoading());
    try {
      final response = await getIsFirstTimeUseCase(NoParams());
      response.fold((failure) => emit(SplashError(error: failure.failure)),
          (isFirstTime) {
        this.isFirstTime = isFirstTime;
        emit(SplashLoaded());
      });
    } catch (error) {
      emit(SplashError(error: error.toString()));
    }
  }

  Future<void> setIsFirstTime() async {
    emit(SetAndGetLoading());
    try {
      final response = await setIsFirstTimeUseCase(NoParams());
      response.fold((failure) => emit(SplashError(error: failure.failure)),
          (success) {
        emit(SetAndGetLoaded());
      });
    } catch (error) {
      emit(SplashError(error: error.toString()));
    }
  }
}
