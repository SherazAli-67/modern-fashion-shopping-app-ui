import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/routing/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: NumberConstant.splashDelaySeconds), _goToOnboarding);
  }

  void _goToOnboarding() {
    if (!mounted) return;
    context.go(NamedRoutes.onboarding.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(1.15, -0.72),
            child: SvgPicture.asset(AssetRes.ringLarge),
          ),
          Align(
            alignment: const Alignment(0.72, -0.58),
            child: SvgPicture.asset(AssetRes.accentDot),
          ),
          Align(
            alignment: const Alignment(-1.2, 0.78),
            child: SvgPicture.asset(AssetRes.ringSmall),
          ),
          Align(
            alignment: const Alignment(-0.62, 0.7),
            child: SvgPicture.asset(AssetRes.accentDot),
          ),
          Center(
            child: Column(
              spacing: NumberConstant.tightSpacing,
              mainAxisSize: .min,
              children: [
                Image.asset(AssetRes.logo, width: NumberConstant.splashLogoSize, height: NumberConstant.splashLogoSize,),
                Row(
                  spacing: 2,
                  mainAxisSize: .min,
                  crossAxisAlignment: .end,
                  children: [
                    Text(StringConst.splashBrand, style: AppTextStyles.splashBrand,),
                    Padding(
                      padding: .only(bottom: 10),
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.accent, borderRadius: .circular(1)),
                        child: const SizedBox(width: NumberConstant.splashBrandDotSize, height: NumberConstant.splashBrandDotSize),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
