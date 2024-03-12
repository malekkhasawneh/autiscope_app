import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:autiscope_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:autiscope_app/features/watch_video/presentation/cubit/watch_video_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashCubit.get(context).getIsFirstTime();
    SplashCubit.get(context).isUserLogin();
    test();
    super.initState();
  }
void test()async{
  await Permission.camera.request();
  await Permission.microphone.request();
}
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) async {
        if (state is SplashLoaded) {
          // await Future.delayed(const Duration(seconds: 5)).then((_) async {
          //   if (SplashCubit.get(context).isFirstTime) {
          //     Navigator.pushNamed(context, Routes.tipsScreen);
          //   } else {
          //     if (SplashCubit.get(context).isLogin) {
          //       await LoginCubit.get(context).getUserInfo().then(
          //           (_) => Navigator.pushNamed(context, Routes.addChildScreen));
          //     } else {
          //       Navigator.pushNamed(context, Routes.loginScreen);
          //     }
          //   }
          // });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  Images.splashLogo,
                  fit: BoxFit.fill,
                ),
                const Text(
                  Strings.kSplashTitle,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  Strings.kSplashSubtitle,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
