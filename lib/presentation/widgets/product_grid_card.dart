import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: .circular(NumberConstant.productCardRadius),
        child: Stack(
          fit: .expand,
          children: [
            Image.asset(product.image, fit: .cover,),
            Positioned(
              top: NumberConstant.tightSpacing,
              right: NumberConstant.tightSpacing,
              child: GestureDetector(
                onTap: onFavoriteTap,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.accent, shape: .circle),
                  child: Padding(
                    padding: .all(5),
                    child: SvgPicture.asset(
                      isFavorite ? AssetRes.icFavoriteFilled : AssetRes.icFavoriteOutlined,
                      colorFilter: .mode(AppColors.white, .srcIn),
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
                        Text(product.brand, style: AppTextStyles.productBrand, maxLines: 1, overflow: .ellipsis,),
                        Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.productPrice,),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onActionTap ?? onTap,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: AppColors.iconButtonBg, shape: .circle),
                      child: Padding(
                        padding: .all(NumberConstant.iconButtonPadding / 2),
                        child: SvgPicture.asset(
                          action == .navigate ? AssetRes.icRedirect : AssetRes.icCart,
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
    );
  }
}
