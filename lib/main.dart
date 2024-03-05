import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/add_child/presentation/cubit/add_child_cubit.dart';
import 'package:autiscope_app/features/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:autiscope_app/features/parent_questions/presentation/cubit/parent_question_cubit.dart';
import 'package:autiscope_app/features/signup/presentation/cubit/sign_up_cubit.dart';
import 'package:autiscope_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:autiscope_app/features/watch_video/presentation/cubit/watch_video_cubit.dart';
import 'package:autiscope_app/injection_container/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load();
  try {
    await Firebase.initializeApp();
  } catch (error) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDI9N59WJ7UERuS3VzMa5sP7QlGghLilfI',
            appId: '1:170308958115:android:b4dafec374c82b8acb4c16',
            messagingSenderId: '',
            projectId: 'autiscope-app'));
  }
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => di.sl<SplashCubit>(),
        ),
        BlocProvider<SignUpCubit>(
          create: (_) => di.sl<SignUpCubit>(),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => di.sl<LoginCubit>(),
        ),
        BlocProvider<AddChildCubit>(
          create: (_) => di.sl<AddChildCubit>(),
        ),
        BlocProvider(
          create: (_) => ParentQuestionCubit(),
        ),
        BlocProvider<WatchVideoCubit>(
          create: (_) => di.sl<WatchVideoCubit>(),
        ),
        BlocProvider<ForgetPasswordCubit>(
          create: (_) => di.sl<ForgetPasswordCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'JO'),
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.splashScreen,
        locale: const Locale('ar', 'JO'),
      ),
    );
  }
}
