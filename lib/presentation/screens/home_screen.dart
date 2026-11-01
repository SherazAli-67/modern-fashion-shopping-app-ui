import 'package:flutter/material.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text(StringConst.homeHeroTitle),),);
  }
}
