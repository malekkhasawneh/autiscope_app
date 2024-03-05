import 'package:autiscope_app/features/forget_password/domain/usecase/reset_password_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  static ForgetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  ForgetPasswordCubit({required this.resetPasswordUseCase})
      : super(ForgetPasswordInitial());

  final ResetPasswordUseCase resetPasswordUseCase;

  bool _check = false;

  bool get getCheck => _check;

  set setCheck(bool value) {
    emit(SetAndGetLoading());
    _check = value;
    emit(SetAndGetLoaded());
  }

  TextEditingController email = TextEditingController();

  Future<void> resetPassword() async {
    emit(ForgetPasswordLoading());
    try {
      final response = await resetPasswordUseCase(
          ResetPasswordUseCaseParams(email: email.text));
      response.fold(
        (failure) => emit(ForgetPasswordError(failure: failure.failure)),
        (success) => emit(
          ForgetPasswordLoaded(success: success),
        ),
      );
    } catch (error) {
      emit(ForgetPasswordError(failure: error.toString()));
    }
  }
}
