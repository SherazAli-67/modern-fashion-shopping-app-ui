import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';

class CircularIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  final double padding;
  final bool showBadge;

  const CircularIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = AppColors.iconButtonBg,
    this.iconColor = AppColors.white,
    this.padding = NumberConstant.circularButtonPadding,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: .none,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: backgroundColor, shape: .circle),
            child: Padding(
              padding: .all(padding),
              child: SvgPicture.asset(icon, colorFilter: .mode(iconColor, .srcIn),),
            ),
          ),
          if (showBadge)
            Positioned(
              top: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.accent, shape: .circle, border: .all(color: AppColors.black, width: 1.5),),
                child: const Padding(padding: .all(4)),
              ),
            ),
        ],
      ),
    );
  }
}
