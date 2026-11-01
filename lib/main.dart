import 'package:flutter/material.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/routing/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .dark,
        fontFamily: StringConst.appFontFamily,
        scaffoldBackgroundColor: AppColors.black,
        colorScheme: .dark(
          primary: AppColors.accent,
          surface: AppColors.black,
          onPrimary: AppColors.white,
          onSurface: AppColors.white,

        ),
      ),
      builder: (ctx, child) => child!,
      routerConfig: router,
    );
  }
}
