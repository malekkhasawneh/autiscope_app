import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/core/widgets/custom_text_field_widget.dart';
import 'package:autiscope_app/features/signup/presentation/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) async {
        if (state is SignUpLoaded) {
          if (state.isSignUp) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تسجيل الحساب بنجاح')));
            await Future.delayed(const Duration(seconds: 3)).then(
                (value) => Navigator.pushNamed(context, Routes.loginScreen));
          }
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('البريد الإلكتروني مستخدم بالفعل'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 30,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  CustomTextFieldWidget(
                    title: Strings.firstName,
                    controller: SignUpCubit.get(context).firstName,
                    check: SignUpCubit.get(context).getCheck,
                    keyBoardType: TextInputType.name,
                  ),
                  CustomTextFieldWidget(
                    title: Strings.lastName,
                    controller: SignUpCubit.get(context).lastName,
                    check: SignUpCubit.get(context).getCheck,
                    keyBoardType: TextInputType.name,
                  ),
                  CustomTextFieldWidget(
                    title: Strings.email,
                    check: SignUpCubit.get(context).getCheck,
                    controller: SignUpCubit.get(context).email,
                    keyBoardType: TextInputType.emailAddress,
                    additionalCheckStatement:
                        !SignUpCubit.get(context).email.text.contains('@'),
                    additionalCheckText: 'تنسيق البريد الالكتروني غير صحيح',
                  ),
                  CustomTextFieldWidget(
                    title: Strings.password,
                    isSecure: true,
                    check: SignUpCubit.get(context).getCheck,
                    controller: SignUpCubit.get(context).password,
                    keyBoardType: TextInputType.visiblePassword,
                    additionalCheckStatement:
                        SignUpCubit.get(context).password.text.length < 6,
                    additionalCheckText: 'يجب ان لا يقل طول كلمة المرور عن ستة',
                  ),
                  CustomTextFieldWidget(
                    title: Strings.confirmPassword,
                    isSecure: true,
                    controller: SignUpCubit.get(context).confirmPassword,
                    check: SignUpCubit.get(context).getCheck,
                    keyBoardType: TextInputType.visiblePassword,
                    additionalCheckStatement:
                        SignUpCubit.get(context).confirmPassword.text !=
                            SignUpCubit.get(context).password.text,
                    additionalCheckText: 'كلمة المرور غير متطابقة',
                  ),
                  const SizedBox(
                    height: 40,
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
                          SignUpCubit.get(context).setCheck = true;
                          if (SignUpCubit.get(context).validateControllers()) {
                            SignUpCubit.get(context).registerNewUser();
                          }
                        },
                        child: (state is SignUpLoading)
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(Strings.register)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
