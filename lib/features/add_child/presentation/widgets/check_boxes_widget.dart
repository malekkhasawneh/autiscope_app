import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/add_child/presentation/cubit/add_child_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxesWidget extends StatelessWidget {
  const CheckBoxesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddChildCubit,AddChildState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(9, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: AddChildCubit.get(context).getFirstChild,
                  onChanged: (bool? value) {
                    AddChildCubit.get(context).setFirstCheckBox = value!;
                  },
                  activeColor: AppColors.darkYellow,
                  side: const BorderSide(
                    color: AppColors.darkYellow,
                    width: 1.5, // Border width
                  ),
                ),
                const Text(
                  Strings.oneYearToThree,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(9, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: AddChildCubit.get(context).getSecondChild,
                  onChanged: (bool? value) {
                    AddChildCubit.get(context).setSecondChild = value!;
                  },
                  activeColor: AppColors.darkYellow,
                  side: const BorderSide(
                    color: AppColors.darkYellow,
                    width: 1.5, // Border width
                  ),
                ),
                const Text(
                  Strings.threeYearToFour,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
          AddChildCubit.get(context).getCheck &&
                  !AddChildCubit.get(context).getFirstChild &&
                  !AddChildCubit.get(context).getSecondChild
              ? const Text(
                  'يرجى اختيار الفئة العمرية',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                )
              : const SizedBox(),
        ],
      );
    });
  }
}
