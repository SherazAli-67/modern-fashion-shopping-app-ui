import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/core/app_animations.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/core/models/product_model.dart';

enum ProductCardAction { navigate, addToCart }

class ProductGridCard extends StatelessWidget {
  final ProductModel product;
  final ProductCardAction action;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onActionTap;
  final bool isFavorite;

  const ProductGridCard({
    super.key,
    required this.product,
    this.action = .navigate,
    this.onTap,
    this.onFavoriteTap,
    this.onActionTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          child: Stack(
            fit: .expand,
            children: [
              ClipRRect(
                borderRadius: .circular(NumberConstant.productCardRadius),
                child: Hero(
                  tag: 'product-image-${product.id}',
                  child: Image.asset(product.image, fit: .cover),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: .circular(NumberConstant.productCardRadius),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.0),
                      Colors.black,
                    ],
                    begin: .topCenter,
                    end: .bottomCenter,
                    stops: const [0.63, 1],
                  ),
                ),
              ),
              Positioned(
                top: NumberConstant.tightSpacing,
                right: NumberConstant.tightSpacing,
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: .circle,
                    ),
                    child: Padding(
                      padding: .all(5),
                      child: AnimatedSwitcher(
                        duration: AppAnimations.fast,
                        switchInCurve: AppAnimations.easeOutCubic,
                        switchOutCurve: AppAnimations.easeOutCubic,
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          isFavorite
                              ? AssetRes.icFavoriteFilled
                              : AssetRes.icFavoriteOutlined,
                          key: ValueKey(isFavorite),
                          colorFilter: .mode(AppColors.white, .srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: NumberConstant.tightSpacing,
                right: NumberConstant.tightSpacing,
                bottom: NumberConstant.tightSpacing,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          Text(product.brand, style: AppTextStyles.productBrand),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: AppTextStyles.productPrice,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onActionTap ?? onTap,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: AppColors.iconButtonBg,
                          shape: .circle,
                        ),
                        child: Padding(
                          padding: .all(NumberConstant.iconButtonPadding / 2),
                          child: SvgPicture.asset(
                            action == .navigate
                                ? AssetRes.icRedirect
                                : AssetRes.icCart,
                            colorFilter: .mode(AppColors.white, .srcIn),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
