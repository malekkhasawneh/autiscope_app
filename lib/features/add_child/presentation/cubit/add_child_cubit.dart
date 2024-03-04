import 'package:autiscope_app/features/add_child/data/model/child_model.dart';
import 'package:autiscope_app/features/add_child/domain/usecase/add_child_usecase.dart';
import 'package:autiscope_app/features/add_child/presentation/page/get_children_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_child_state.dart';

class AddChildCubit extends Cubit<AddChildState> {
  static AddChildCubit get(BuildContext context) => BlocProvider.of(context);

  AddChildCubit({
    required this.addChildUseCase,
    required this.getChildrenUseCase,
  }) : super(AddChildInitial());

  final AddChildUseCase addChildUseCase;
  final GetChildrenUseCase getChildrenUseCase;

  bool _check = false;

  bool get getCheck => _check;

  set setCheck(bool value) {
    emit(SetAndGetLoading());
    _check = value;
    emit(SetAndGetLoaded());
  }

  Future<void> addChild() async {
    emit(AddChildLoading());
    try {
      final response = await addChildUseCase(AddChildUseCaseParams(
          userId: userId, name: name, nickName: nickName, age: age));
    } catch (error) {
      emit(AddChildError(failure: error.toString()));
    }
  }
}
