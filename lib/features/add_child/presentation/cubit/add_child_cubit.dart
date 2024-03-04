import 'dart:developer';

import 'package:autiscope_app/features/add_child/data/model/child_model.dart';
import 'package:autiscope_app/features/add_child/domain/usecase/add_child_usecase.dart';
import 'package:autiscope_app/features/add_child/domain/usecase/get_children_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  TextEditingController name = TextEditingController();
  TextEditingController nickName = TextEditingController();
  bool _firstCheckBox = false;
  bool _secondCheckBox = false;

  bool get getFirstChild => _firstCheckBox;

  set setFirstCheckBox(bool value) {
    emit(SetAndGetLoading());
    _firstCheckBox = value;
    emit(SetAndGetLoaded());
  }

  bool get getSecondChild => _secondCheckBox;

  set setSecondChild(bool value) {
    emit(SetAndGetLoading());
    _secondCheckBox = value;
    emit(SetAndGetLoaded());
  }

  bool _check = false;

  bool get getCheck => _check;

  set setCheck(bool value) {
    emit(SetAndGetLoading());
    _check = value;
    emit(SetAndGetLoaded());
  }

  Future<void> addChild({required String userId}) async {
    emit(AddChildLoading());
    try {
      final response = await addChildUseCase(AddChildUseCaseParams(
          userId: userId,
          name: name.text,
          nickName: nickName.text,
          age: _firstCheckBox ? 'one-three' : 'three-four'));
      response.fold(
          (failure) => emit(AddChildError(
                failure: failure.failure,
              )),
          (success) => emit(
                AddChildLoaded(success: success),
              ));
    } catch (error) {
      emit(AddChildError(failure: error.toString()));
    }
  }

  List<ChildModel> children = [];

  Future<void> getChildren({required String userId}) async {
    emit(AddChildLoading());
    try {
      final response =
          await getChildrenUseCase(GetChildrenUseCaseParams(userId: userId));
      response.fold(
          (failure) => emit(AddChildError(
                failure: failure.failure,
              )), (children) {
        this.children = children;
        log('============================ length ${children.length}');
        emit(
          GetChildLoaded(childModel: children),
        );
      });
    } catch (error) {
      emit(AddChildError(failure: error.toString()));
    }
  }

  bool validateFields() {
    return name.text.isNotEmpty &&
        nickName.text.isNotEmpty &&
        (_firstCheckBox != false || _secondCheckBox != false);
  }

  void restValues() {
    emit(SetAndGetLoading());
    name.clear();
    nickName.clear();
    _firstCheckBox = false;
    _secondCheckBox = false;
    emit(SetAndGetLoaded());
  }
}
