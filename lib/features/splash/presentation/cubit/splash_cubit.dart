import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  static SplashCubit get(BuildContext context) => BlocProvider.of(context);
  SplashCubit() : super(SplashInitial());

  bool _isTipsChecked = false;

  bool get getIsTipsChecked => _isTipsChecked;

  set setIsTipsChecked(bool value) {
    emit(SetAndGetLoading());
    _isTipsChecked = value;
    emit(SetAndGetLoaded());
  }
}
