import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/core/widgets/custom_text_field_widget.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoginLoaded) {
        Navigator.pushNamed(context, Routes.addChildScreen);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  Strings.login,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                CustomTextFieldWidget(
                  title: Strings.email,
                  controller: LoginCubit.get(context).email,
                  check: LoginCubit.get(context).getCheck,
                ),
                CustomTextFieldWidget(
                  title: Strings.password,
                  isSecure: true,
                  controller: LoginCubit.get(context).password,
                  check: LoginCubit.get(context).getCheck,
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
                        LoginCubit.get(context).setCheck = true;
                        if (LoginCubit.get(context).validateFields()) {
                          LoginCubit.get(context).login();
                        }
                      },
                      child: const Text(Strings.login)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.forgetPassword,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      Strings.newUser,
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
