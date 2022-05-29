import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _initSharedPrefs();
  }

  //init shared prefs
  _initSharedPrefs() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _endIntroScreen(context) async {
    await _preferences.setBool('displayedIntroScreen', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        showDoneButton: true,
        showNextButton: true,
        showSkipButton: true,
        skip: const Text(
          'Skip',
          style: TextStyle(
            fontFamily: 'baloo da 2',
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.red
          ),
        ),
        next: const Text(
          'Next',
          style: TextStyle(
            fontFamily: 'baloo da 2',
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.red
          ),
        ),
        done: const Text(
          'Sign Up',
          style: TextStyle(
            fontFamily: 'baloo da 2',
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: Colors.red
          ),
        ),
        onDone: () {_endIntroScreen(context);},
        pages: [
          PageViewModel(
            title: 'FWOO Demo Store',
            body: 'Welcome to the FWOO Demo Store. This is a demo store that is used to showcase the functionality of the Flutter and Woocommerce.',
            // image: Image.asset('assets/onboarding1.png'),
            decoration: const PageDecoration(
              fullScreen: true,
              imageAlignment: Alignment.center,
              imagePadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              footerPadding: EdgeInsets.zero,
               ),
          ),

          PageViewModel(
            title: '',
            body: '',
            image: Image.asset('assets/onboarding/1.png'),
            decoration: const PageDecoration(
              fullScreen: true,
              pageColor: Colors.red,
               ),
          ),

          PageViewModel(
            title: '',
            body: '',
            image: Image.asset('assets/onboarding/2.png'),
            decoration: const PageDecoration(
              fullScreen: true,
              pageColor: Colors.red,
               ),
          ),

           PageViewModel(
            title: '',
            body: '',
            image: Image.asset('assets/onboarding/3.png'),
            decoration: const PageDecoration(
              fullScreen: true,
              pageColor: Colors.red,
               ),
          ),
        ],
      );
  }
}