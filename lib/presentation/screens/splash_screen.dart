import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_animations.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/routing/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _brandOpacity;
  late final Animation<Offset> _brandSlide;
  late final Animation<double> _topDecorOpacity;
  late final Animation<Offset> _topDecorSlide;
  late final Animation<double> _bottomDecorOpacity;
  late final Animation<Offset> _bottomDecorSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.splash,
    );

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: AppAnimations.easeOutCubic),
    );
    _logoScale = Tween<double>(begin: 0.82, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: AppAnimations.easeOutCubic),
      ),
    );

    _brandOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.6, curve: AppAnimations.easeOutCubic),
    );
    _brandSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: AppAnimations.easeOutCubic),
      ),
    );

    _topDecorOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.75, curve: AppAnimations.easeOutCubic),
    );
    _topDecorSlide = Tween<Offset>(
      begin: const Offset(0.08, -0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.75, curve: AppAnimations.easeOutCubic),
      ),
    );

    _bottomDecorOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.9, curve: AppAnimations.easeOutCubic),
    );
    _bottomDecorSlide = Tween<Offset>(
      begin: const Offset(-0.08, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.9, curve: AppAnimations.easeOutCubic),
      ),
    );

    _controller.forward();
    Future.delayed(
      const Duration(seconds: NumberConstant.splashDelaySeconds),
      _goToOnboarding,
    );
  }

  void _goToOnboarding() {
    if (!mounted) return;
    context.go(NamedRoutes.onboarding.routeName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(1.15, -0.72),
            child: FadeTransition(
              opacity: _topDecorOpacity,
              child: SlideTransition(
                position: _topDecorSlide,
                child: SvgPicture.asset(AssetRes.ringLarge),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.72, -0.58),
            child: FadeTransition(
              opacity: _topDecorOpacity,
              child: SlideTransition(
                position: _topDecorSlide,
                child: SvgPicture.asset(AssetRes.accentDot),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-1.2, 0.78),
            child: FadeTransition(
              opacity: _bottomDecorOpacity,
              child: SlideTransition(
                position: _bottomDecorSlide,
                child: SvgPicture.asset(AssetRes.ringSmall),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.62, 0.7),
            child: FadeTransition(
              opacity: _bottomDecorOpacity,
              child: SlideTransition(
                position: _bottomDecorSlide,
                child: SvgPicture.asset(AssetRes.accentDot),
              ),
            ),
          ),
          Center(
            child: Column(
              spacing: NumberConstant.tightSpacing,
              mainAxisSize: .min,
              children: [
                FadeTransition(
                  opacity: _logoOpacity,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: Image.asset(
                      AssetRes.logo,
                      width: NumberConstant.splashLogoSize,
                      height: NumberConstant.splashLogoSize,
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _brandOpacity,
                  child: SlideTransition(
                    position: _brandSlide,
                    child: Row(
                      spacing: 2,
                      mainAxisSize: .min,
                      crossAxisAlignment: .end,
                      children: [
                        Text(
                          StringConst.splashBrand,
                          style: AppTextStyles.splashBrand,
                        ),
                        Padding(
                          padding: .only(bottom: 10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: .circular(1),
                            ),
                            child: const SizedBox(
                              width: NumberConstant.splashBrandDotSize,
                              height: NumberConstant.splashBrandDotSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
