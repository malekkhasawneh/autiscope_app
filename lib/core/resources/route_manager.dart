part of 'resources.dart';

class Routes {
  static const String splashScreen = "/";
  static const String tipsScreen = "/TipsScreen";
  static const String loginScreen = "/LoginScreen";
  static const String addChildScreen = "/AddChildScreen";
  static const String forgetPasswordScreen = "/ForgetPasswordScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String parentQuestionsScreen = "/ParentQuestionsScreen";
  static const String watchVideoScreen = "/WatchVideoScreen";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: const RouteSettings(name: Routes.splashScreen),
        );
      case Routes.tipsScreen:
        return MaterialPageRoute(
          builder: (_) => const TipsScreen(),
          settings: const RouteSettings(name: Routes.tipsScreen),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: const RouteSettings(name: Routes.loginScreen),
        );
      case Routes.addChildScreen:
        return MaterialPageRoute(
          builder: (_) => const AddChildScreen(),
          settings: const RouteSettings(name: Routes.addChildScreen),
        );
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
          settings: const RouteSettings(name: Routes.forgetPasswordScreen),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: const RouteSettings(name: Routes.signUpScreen),
        );
      case Routes.parentQuestionsScreen:
        return MaterialPageRoute(
          builder: (_) => const ParentQuestionsScreen(),
          settings: const RouteSettings(name: Routes.parentQuestionsScreen),
        );
      case Routes.watchVideoScreen:
        return MaterialPageRoute(
          builder: (_) => const WatchVideoScreen(),
          settings: const RouteSettings(name: Routes.watchVideoScreen),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('page not found'),
        ),
      ),
    );
  }
}
