import 'package:flutter/material.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text(StringConst.onboardingCta),),);
  }
}
