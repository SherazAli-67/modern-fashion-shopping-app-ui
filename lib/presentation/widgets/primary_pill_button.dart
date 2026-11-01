import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';

class PrimaryPillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final TextStyle textStyle;
  final String? trailingIcon;
  final double height;
  final Color? borderColor;

  const PrimaryPillButton({
    super.key,
    required this.label,
    this.onTap,
    this.backgroundColor = AppColors.accent,
    this.textStyle = AppTextStyles.primaryCta,
    this.trailingIcon,
    this.height = NumberConstant.onboardingCtaHeight,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: .circular(NumberConstant.pillRadius),
          border: borderColor == null ? null : .all(color: borderColor!),
        ),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Row(
            spacing: NumberConstant.tightSpacing,
            mainAxisAlignment: .center,
            children: [
              Text(label, style: textStyle,),
              if (trailingIcon != null) SvgPicture.asset(trailingIcon!, colorFilter: .mode(textStyle.color ?? AppColors.white, .srcIn),),
            ],
          ),
        ),
      ),
    );
  }
}
