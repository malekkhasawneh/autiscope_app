import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40,),
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
            const SizedBox(height: 70,),
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
  }
}
