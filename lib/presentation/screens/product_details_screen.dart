import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_data.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/core/models/product_model.dart';
import 'package:modern_shopping_app_ui/presentation/providers/product_details_provider.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/circular_icon_button.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/primary_pill_button.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = AppData.productById(productId);
    if (product == null) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: Column(
            spacing: NumberConstant.itemSpacing,
            children: [
              Align(
                alignment: .centerLeft,
                child: Padding(
                  padding: .all(NumberConstant.horizontalPadding),
                  child: CircularIconButton(icon: AssetRes.icArrowBack, onTap: () => context.pop(),),
                ),
              ),
              const Expanded(child: Center(child: Text(StringConst.productNotFound, style: AppTextStyles.sectionTitle,),)),
            ],
          ),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => ProductDetailsProvider(product),
      child: const _ProductDetailsView(),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  const _ProductDetailsView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductDetailsProvider>();
    final product = provider.product;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Expanded(child: _buildHero(context, provider)),
          _buildDetailsSheet(context, provider, product),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context, ProductDetailsProvider provider) {
    return Stack(
      fit: .expand,
      children: [
        Image.asset(provider.selectedImage, fit: .cover, width: double.infinity, height: double.infinity,),
        SafeArea(
          child: Padding(
            padding: .symmetric(horizontal: NumberConstant.horizontalPadding, vertical: NumberConstant.tightSpacing),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                CircularIconButton(icon: AssetRes.icArrowBack, onTap: () => context.pop(),),
                CircularIconButton(icon: AssetRes.icExpand, onTap: () {},),
              ],
            ),
          ),
        ),
        Positioned(
          left: NumberConstant.horizontalPadding,
          right: NumberConstant.horizontalPadding,
          bottom: NumberConstant.itemSpacing,
          child: Row(
            spacing: NumberConstant.tightSpacing,
            children: [
              for (var i = 0; i < provider.gallery.length; i++)
                Expanded(
                  child: GestureDetector(
                    onTap: () => provider.selectImage(i),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: .circular(NumberConstant.thumbnailRadius),
                        border: .all(color: i == provider.selectedImageIndex ? AppColors.white : AppColors.whiteBorder, width: 1.5),
                      ),
                      child: ClipRRect(
                        borderRadius: .circular(NumberConstant.thumbnailRadius - 1),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(provider.gallery[i], fit: .cover,),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSheet(BuildContext context, ProductDetailsProvider provider, ProductModel product) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: .vertical(top: .circular(NumberConstant.detailsSheetRadius)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.itemSpacing, NumberConstant.horizontalPadding, NumberConstant.itemSpacing),
          child: Column(
            spacing: NumberConstant.itemSpacing,
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              Column(
                spacing: 4,
                children: [
                  Text(product.category.toUpperCase(), style: AppTextStyles.detailsCategory, textAlign: .center,),
                  Text(product.brand.toUpperCase(), style: AppTextStyles.detailsTitle, textAlign: .center,),
                ],
              ),
              _buildDescription(provider, product),
              const Divider(color: AppColors.border, height: 1),
              _buildSelectors(provider),
              _buildPriceRow(product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(ProductDetailsProvider provider, ProductModel product) {
    final canExpand = product.description.length > 90;
    final body = !canExpand || provider.isDescriptionExpanded
        ? '${product.description} '
        : '${product.description.substring(0, 90)}… ';
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: body, style: AppTextStyles.detailsDescription),
          if (canExpand)
            WidgetSpan(
              alignment: .baseline,
              baseline: .alphabetic,
              child: GestureDetector(
                onTap: provider.toggleDescription,
                child: Text(provider.isDescriptionExpanded ? StringConst.readLess : StringConst.readMore, style: AppTextStyles.detailsReadMore,),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectors(ProductDetailsProvider provider) {
    return ClipRRect(
      borderRadius: .circular(NumberConstant.capsuleRadius),
      child: CustomPaint(
        painter: const _DiagonalStripePainter(),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: .circular(NumberConstant.capsuleRadius),
            border: .all(color: AppColors.border),
          ),
          child: SizedBox(
            height: NumberConstant.selectorHeight,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: provider.selectNextColor,
                    behavior: .opaque,
                    child: Padding(
                      padding: .symmetric(horizontal: NumberConstant.itemSpacing),
                      child: Row(
                        spacing: NumberConstant.tightSpacing,
                        children: [
                          Text(StringConst.colorLabel.toUpperCase(), style: AppTextStyles.detailsSelector,),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(int.parse('FF${provider.selectedColor.substring(1)}', radix: 16)),
                              borderRadius: .circular(NumberConstant.pillRadius),
                              border: .all(color: AppColors.whiteBorder),
                            ),
                            child: const SizedBox(width: 40, height: 18),
                          ),
                          SvgPicture.asset(AssetRes.icChevronDown, colorFilter: .mode(AppColors.white, .srcIn),),
                        ],
                      ),
                    ),
                  ),
                ),
                const ColoredBox(color: AppColors.border, child: SizedBox(width: 1, height: 30)),
                Expanded(
                  child: GestureDetector(
                    onTap: provider.selectNextSize,
                    behavior: .opaque,
                    child: Padding(
                      padding: .symmetric(horizontal: NumberConstant.itemSpacing),
                      child: Row(
                        spacing: NumberConstant.tightSpacing,
                        mainAxisAlignment: .center,
                        children: [
                          Text('${StringConst.sizeLabel} ${provider.selectedSize}'.toUpperCase(), style: AppTextStyles.detailsSelector,),
                          SvgPicture.asset(AssetRes.icChevronDown, colorFilter: .mode(AppColors.white, .srcIn),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(ProductModel product) {
    return Row(
      spacing: NumberConstant.itemSpacing,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.detailsPrice,),
            if (product.oldPrice != null) Text('\$${product.oldPrice!.toStringAsFixed(2)}', style: AppTextStyles.detailsOldPrice,),
          ],
        ),
        Expanded(
          child: PrimaryPillButton(
            label: StringConst.addToCart.toUpperCase(),
            backgroundColor: AppColors.white,
            textStyle: AppTextStyles.addToCart,
            height: NumberConstant.addToCartHeight,
            borderColor: AppColors.whiteBorder,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _DiagonalStripePainter extends CustomPainter {
  const _DiagonalStripePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2A2A2A)
      ..strokeWidth = 1
      ..style = .stroke;
    const gap = 10.0;
    for (double x = -size.height; x < size.width + size.height; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
