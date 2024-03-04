import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:autiscope_app/features/signup/presentation/cubit/sign_up_cubit.dart';
import 'package:autiscope_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:autiscope_app/injection_container/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDI9N59WJ7UERuS3VzMa5sP7QlGghLilfI',
          appId: '1:170308958115:android:b4dafec374c82b8acb4c16',
          messagingSenderId: '',
          projectId: 'autiscope-app'));
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SplashCubit(),
        ),
        BlocProvider<SignUpCubit>(
          create: (_) => di.sl<SignUpCubit>(),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => di.sl<LoginCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.signUpScreen,
        locale: const Locale('ar', 'JO'),
      ),
    );
  }
}
