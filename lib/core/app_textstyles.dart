import 'package:flutter/material.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';

class AppTextStyles {
  static const _font = StringConst.appFontFamily;

  static const splashBrand = TextStyle(
    fontFamily: _font,
    fontWeight: .w400,
    fontSize: 43.5,
    letterSpacing: 2.17,
    color: AppColors.accent,
    height: 1.16,
  );

  static const onboardingWatermark = TextStyle(
    fontFamily: _font,
    fontWeight: .w400,
    fontSize: 74,
    letterSpacing: 14.8,
    color: AppColors.watermark,
    height: 1,
  );

  static const onboardingHeadline = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 24,
    color: AppColors.white,
  );

  static const onboardingHeadlineAccent = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 24,
    color: AppColors.accent,
  );

  static const primaryCta = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 24,
    color: AppColors.white,
  );

  static const homeWelcome = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 12,
    color: AppColors.white,
  );

  static const homeUserName = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 18,
    color: AppColors.accent,
  );

  static const homeHeroTitle = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 34,
    color: AppColors.white,
    height: 1.2,
  );

  static const homeHeroHighlight = TextStyle(
    fontFamily: _font,
    fontWeight: .w600,
    fontSize: 34,
    color: AppColors.accent,
    height: 1.2,
  );

  static const discountBadge = TextStyle(
    fontFamily: _font,
    fontWeight: .w700,
    fontSize: 12,
    color: AppColors.white,
  );

  static const discountOff = TextStyle(
    fontFamily: _font,
    fontWeight: .w600,
    fontSize: 8,
    color: AppColors.white,
  );

  static const categoryLabelSelected = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.accent,
  );

  static const sectionTitle = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 18,
    color: AppColors.white,
  );

  static const categoryLabel = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.white,
  );

  static const chipLabel = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.white,
  );

  static const chipLabelSelected = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.black,
  );

  static const productBrand = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 12,
    color: AppColors.white,
  );

  static const productPrice = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.white,
  );

  static const screenTitle = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 24,
    color: AppColors.white,
  );

  static const detailsCategory = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.muted,
  );

  static const detailsTitle = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 30,
    color: AppColors.white,
  );

  static const detailsDescription = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 14,
    color: AppColors.muted,
    height: 1.5,
  );

  static const detailsReadMore = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 14,
    color: AppColors.white,
    height: 1.5,
    decoration: .underline,
    decorationColor: AppColors.white,
  );

  static const detailsSelector = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.white,
  );

  static const detailsPrice = TextStyle(
    fontFamily: _font,
    fontWeight: .w600,
    fontSize: 24,
    color: AppColors.accent,
  );

  static const detailsOldPrice = TextStyle(
    fontFamily: _font,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.muted,
    decoration: .lineThrough,
    decorationColor: AppColors.muted,
  );

  static const addToCart = TextStyle(
    fontFamily: _font,
    fontWeight: .w600,
    fontSize: 16,
    color: AppColors.black,
  );
}
