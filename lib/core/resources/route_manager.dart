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
  static const String charQuestionOneScreen = "/CharQuestionOneScreen";
  static const String charQuestionTwoScreen = "/CharQuestionTwoScreen";
  static const String charQuestionThreeScreen = "/CharQuestionThreeScreen";
  static const String charQuestionFourScreen = "/CharQuestionFourScreen";
  static const String flipQuestionScreen = "/FlipQuestionScreen";
  static const String questionTipScreen = '/QuestionTipScreen';
  static const String matchingQuestionScreen = "/matchingQuestionScreen";
  static const String followTheUrchinScreen = "/followTheUrchinScreen";
  static const String catQuestionScreen = "/CatQuestionScreen";
  static const String lionQuestionScreen = "/LionQuestionScreen";
  static const String findDifferenceScreen = "/FindDifferenceScreen";
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
      case Routes.charQuestionOneScreen:
        return MaterialPageRoute(
          builder: (_) => const CharacterQuestionOneScreen(),
          settings: const RouteSettings(name: Routes.charQuestionOneScreen),
        );
      case Routes.charQuestionTwoScreen:
        return MaterialPageRoute(
          builder: (_) => const CharacterQuestionTwoScreen(),
          settings: const RouteSettings(name: Routes.charQuestionTwoScreen),
        );
      case Routes.charQuestionThreeScreen:
        return MaterialPageRoute(
          builder: (_) => const CharacterQuestionThreeScreen(),
          settings: const RouteSettings(name: Routes.charQuestionThreeScreen),
        );
      case Routes.charQuestionFourScreen:
        return MaterialPageRoute(
          builder: (_) => const CharacterQuestionFourScreen(),
          settings: const RouteSettings(name: Routes.charQuestionFourScreen),
        );
      case Routes.flipQuestionScreen:
        return MaterialPageRoute(
          builder: (_) => const FlipQuestionScreen(),
          settings: const RouteSettings(name: Routes.flipQuestionScreen),
        );
      case Routes.questionTipScreen:
        return MaterialPageRoute(
          builder: (_) => const QuestionTipScreen(),
          settings: const RouteSettings(name: Routes.questionTipScreen),
        );
      case Routes.matchingQuestionScreen:
        return MaterialPageRoute(
          builder: (_) => MatchingQuestionScreen(),
          settings: const RouteSettings(name: Routes.matchingQuestionScreen),
        );
      case Routes.followTheUrchinScreen:
        return MaterialPageRoute(
          builder: (_) => const FollowTheUrchinScreen(),
          settings: const RouteSettings(name: Routes.followTheUrchinScreen),
        );
      case Routes.catQuestionScreen:
        return MaterialPageRoute(
          builder: (_) => const CatQuestionScreen(),
          settings: const RouteSettings(name: Routes.catQuestionScreen),
        );
      case Routes.lionQuestionScreen:
        return MaterialPageRoute(
          builder: (_) => const LionQuestionScreen(),
          settings: const RouteSettings(name: Routes.lionQuestionScreen),
        );
      case Routes.findDifferenceScreen:
        return MaterialPageRoute(
          builder: (_) => const FindDifferenceScreen(),
          settings: const RouteSettings(name: Routes.findDifferenceScreen),
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
