import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/core/widgets/custom_text_field_widget.dart';
import 'package:autiscope_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit,ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoaded) {
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('تم ارسال الرابط الى البريد الالكتروني')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('يرجى التحقق من البريد المدخل')));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomTextFieldWidget(
                title: Strings.email,
                controller: ForgetPasswordCubit.get(context).email,
                keyBoardType: TextInputType.emailAddress,
                check: ForgetPasswordCubit.get(context).getCheck,
              ),
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Border radius here
                      ),
                    ),
                    onPressed: () {
                      ForgetPasswordCubit.get(context).setCheck = true;
                      if (ForgetPasswordCubit.get(context)
                          .email
                          .text
                          .isNotEmpty) {
                        ForgetPasswordCubit.get(context).resetPassword();
                      }
                    },
                    child: const Text(Strings.confirm)),
              ),
            ]),
          ),
        );
      },
    );
  }
}
