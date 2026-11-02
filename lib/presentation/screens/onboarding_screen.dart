import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/primary_pill_button.dart';
import 'package:modern_shopping_app_ui/routing/router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
              // _buildWatermark(),
              Expanded(flex: 5, child: _buildCollage()),
              _buildHeadline(),
              /*PrimaryPillButton(
                label: StringConst.onboardingCta,
                trailingIcon: AssetRes.icArrowNext,
                onTap: () => context.go(NamedRoutes.home.routeName),
              ),*/
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
          child: Text(StringConst.onboardingWatermark, style: AppTextStyles.onboardingWatermark, textAlign: .center, softWrap: false,),
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
          //svg: ringLarge
          child: const SizedBox()
        ),
        Align(
          alignment: const Alignment(-1.25, 0.55),
          //svg: ringSmall
          child: SizedBox()
        ),
        Align(
          alignment: const Alignment(-0.05, -0.95),
          //icFlower
          child: SizedBox()
        ),
        Align(
          alignment: const Alignment(0.05, 0.98),
          //icFlower, accent
          child:SizedBox()
        ),
        Row(
          spacing: NumberConstant.collageGap,
          crossAxisAlignment: .stretch,
          children: [
           /* Expanded(
              child: _buildCollageImage(
                asset: AssetRes.splashImg1,
                borderRadius: .circular(NumberConstant.onboardingImageRadius),
              ),
            ),*/
            Expanded(
              child: Column(
                spacing: NumberConstant.collageGap,
                children: [
                 /* Expanded(
                    flex: 5,
                    child: _buildCollageImage(
                      asset: AssetRes.splashImg3,
                      borderRadius: .circular(NumberConstant.onboardingRightImageRadius),
                    ),
                  ),*/
                 /* Expanded(
                    flex: 4,
                    child: _buildCollageImage(
                      asset: AssetRes.splashImg2,
                      borderRadius: .circular(NumberConstant.onboardingRightImageRadius),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCollageImage({required String asset, required BorderRadius borderRadius}) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(asset, fit: .cover, width: double.infinity, height: double.infinity,),
    );
  }

  Widget _buildHeadline() {
    return Column(
      spacing: NumberConstant.onboardingHeadlineSpacing,
      children: [
        //onboardingHeadline1, onboardingHeadline, .center
        Stack(
          alignment: .centerLeft,
          children: [
            //icHeadlineUnderline
            Text.rich(
              TextSpan(
                children: [
                  //onboardingLine2Prefix, onboardingHeadlineAccent,
                  //onboardingLine2Suffix, onboardingHeadline
                ],
              ),
              textAlign: .center,
            ),
          ],
        ),
        //onboardingHeadline3, onboardingHeadline, .center
      ],
    );
  }
}
