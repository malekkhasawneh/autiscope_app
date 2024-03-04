import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:autiscope_app/features/splash/presentation/widgets/text_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) async {
        if (SplashCubit.get(context).getIsTipsChecked) {
          await Future.delayed(const Duration(seconds: 1)).then(
            (_) => Navigator.pushNamed(context, Routes.loginScreen),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 50),
            margin: const EdgeInsets.symmetric(horizontal: 17),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const TextCustomWidget(
                    text: Strings.kTipsTitle,
                    isTitle: true,
                  ),
                  const TextCustomWidget(
                    text: Strings.kTip1,
                  ),
                  const TextCustomWidget(
                    text: Strings.kTip2,
                  ),
                  const TextCustomWidget(
                    text: Strings.kTip3,
                  ),
                  const TextCustomWidget(
                    text: Strings.kTip4,
                  ),
                  const TextCustomWidget(
                    text: Strings.kTip5,
                  ),
                  const TextCustomWidget(
                    text: Strings.kTip6,
                  ),
                  const TextCustomWidget(
                    text: Strings.kTip7,
                  ),
                  const TextCustomWidget(
                    text: Strings.kTip8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value:  SplashCubit.get(context).getIsTipsChecked,
                        onChanged: (bool? value) {
                          SplashCubit.get(context).setIsFirstTime();
                          SplashCubit.get(context).setIsTipsChecked = value!;
                        },
                        activeColor: AppColors.darkYellow,
                        side: const BorderSide(
                          color: AppColors.darkYellow,
                          width: 1.5, // Border width
                        ),
                      ),
                      const Text(
                        'فهمت',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
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
