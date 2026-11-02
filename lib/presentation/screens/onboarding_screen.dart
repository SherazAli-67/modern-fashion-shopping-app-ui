import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_animations.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/primary_pill_button.dart';
import 'package:modern_shopping_app_ui/routing/router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _watermarkOpacity;
  late final Animation<double> _leftImageOpacity;
  late final Animation<Offset> _leftImageSlide;
  late final Animation<double> _rightTopOpacity;
  late final Animation<Offset> _rightTopSlide;
  late final Animation<double> _rightBottomOpacity;
  late final Animation<Offset> _rightBottomSlide;
  late final Animation<double> _decorOpacity;
  late final Animation<double> _headlineOpacity;
  late final Animation<Offset> _headlineSlide;
  late final Animation<double> _ctaOpacity;
  late final Animation<Offset> _ctaSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.onboarding,
    );

    _watermarkOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: AppAnimations.easeOutCubic),
    );

    _leftImageOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 0.45, curve: AppAnimations.easeOutCubic),
    );
    _leftImageSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.45, curve: AppAnimations.easeOutCubic),
      ),
    );

    _rightTopOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.22, 0.55, curve: AppAnimations.easeOutCubic),
    );
    _rightTopSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.22, 0.55, curve: AppAnimations.easeOutCubic),
      ),
    );

    _rightBottomOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.32, 0.65, curve: AppAnimations.easeOutCubic),
    );
    _rightBottomSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.32, 0.65, curve: AppAnimations.easeOutCubic),
      ),
    );

    _decorOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 0.65, curve: AppAnimations.easeOutCubic),
    );

    _headlineOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.82, curve: AppAnimations.easeOutCubic),
    );
    _headlineSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.82, curve: AppAnimations.easeOutCubic),
      ),
    );

    _ctaOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.62, 0.95, curve: AppAnimations.easeOutCubic),
    );
    _ctaSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.62, 0.95, curve: AppAnimations.easeOutCubic),
      ),
    );

    _controller.forward();
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
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
          child: Column(
            spacing: NumberConstant.itemSpacing,
            children: [
              FadeTransition(
                opacity: _watermarkOpacity,
                child: _buildWatermark(),
              ),
              Expanded(flex: 5, child: _buildCollage()),
              FadeTransition(
                opacity: _headlineOpacity,
                child: SlideTransition(
                  position: _headlineSlide,
                  child: _buildHeadline(),
                ),
              ),
              FadeTransition(
                opacity: _ctaOpacity,
                child: SlideTransition(
                  position: _ctaSlide,
                  child: PressableScale(
                    child: PrimaryPillButton(
                      label: StringConst.onboardingCta,
                      trailingIcon: AssetRes.icArrowNext,
                      onTap: () => context.go(NamedRoutes.home.routeName),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWatermark() {
    return ClipRect(
      child: SizedBox(
        height: 72,
        width: double.infinity,
        child: OverflowBox(
          maxWidth: double.infinity,
          alignment: .center,
          child: Text(
            StringConst.onboardingWatermark,
            style: AppTextStyles.onboardingWatermark,
            textAlign: .center,
            softWrap: false,
          ),
        ),
      ),
    );
  }

  Widget _buildCollage() {
    return Stack(
      clipBehavior: .none,
      children: [
        Align(
          alignment: const Alignment(1.35, -0.05),
          child: FadeTransition(
            opacity: _decorOpacity,
            child: SvgPicture.asset(AssetRes.ringLarge),
          ),
        ),
        Align(
          alignment: const Alignment(-1.25, 0.55),
          child: FadeTransition(
            opacity: _decorOpacity,
            child: SvgPicture.asset(AssetRes.ringSmall),
          ),
        ),
        Align(
          alignment: const Alignment(-0.05, -0.95),
          child: FadeTransition(
            opacity: _decorOpacity,
            child: SvgPicture.asset(AssetRes.icFlower),
          ),
        ),
        Align(
          alignment: const Alignment(0.05, 0.98),
          child: FadeTransition(
            opacity: _decorOpacity,
            child: SvgPicture.asset(
              AssetRes.icFlower,
              colorFilter: .mode(AppColors.accent, .srcIn),
            ),
          ),
        ),
        Row(
          spacing: NumberConstant.collageGap,
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: FadeTransition(
                opacity: _leftImageOpacity,
                child: SlideTransition(
                  position: _leftImageSlide,
                  child: _buildCollageImage(
                    asset: AssetRes.splashImg1,
                    borderRadius: .circular(NumberConstant.onboardingImageRadius),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                spacing: NumberConstant.collageGap,
                children: [
                  Expanded(
                    flex: 5,
                    child: FadeTransition(
                      opacity: _rightTopOpacity,
                      child: SlideTransition(
                        position: _rightTopSlide,
                        child: _buildCollageImage(
                          asset: AssetRes.splashImg3,
                          borderRadius: .circular(
                            NumberConstant.onboardingRightImageRadius,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: FadeTransition(
                      opacity: _rightBottomOpacity,
                      child: SlideTransition(
                        position: _rightBottomSlide,
                        child: _buildCollageImage(
                          asset: AssetRes.splashImg2,
                          borderRadius: .circular(
                            NumberConstant.onboardingRightImageRadius,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCollageImage({
    required String asset,
    required BorderRadius borderRadius,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        asset,
        fit: .cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildHeadline() {
    return Column(
      spacing: NumberConstant.onboardingHeadlineSpacing,
      children: [
        Text(
          StringConst.onboardingLine1,
          style: AppTextStyles.onboardingHeadline,
        ),
        Stack(
          alignment: .centerLeft,
          children: [
            SvgPicture.asset(AssetRes.icHeadlineUnderline),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: StringConst.onboardingLine2Prefix,
                    style: AppTextStyles.onboardingHeadlineAccent,
                  ),
                  TextSpan(
                    text: StringConst.onboardingLine2Suffix,
                    style: AppTextStyles.onboardingHeadline,
                  ),
                ],
              ),
              textAlign: .center,
            ),
          ],
        ),
        Text(
          StringConst.onboardingLine3,
          style: AppTextStyles.onboardingHeadline,
        ),
      ],
    );
  }
}
