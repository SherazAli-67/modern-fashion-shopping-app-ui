import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_data.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/core/models/category_model.dart';
import 'package:modern_shopping_app_ui/core/models/product_model.dart';
import 'package:modern_shopping_app_ui/presentation/providers/home_provider.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/circular_icon_button.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/filter_chip_row.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/product_grid_card.dart';
import 'package:modern_shopping_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final products = provider.filteredProducts;
    final leftProducts = [for (var i = 0; i < products.length; i += 2) products[i]];
    final rightProducts = [for (var i = 1; i < products.length; i += 2) products[i]];

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.itemSpacing, NumberConstant.horizontalPadding, NumberConstant.sectionSpacing),
          child: Column(
            spacing: NumberConstant.sectionSpacing,
            crossAxisAlignment: .stretch,
            children: [
              _buildHeader(context),
              _buildHero(),
              _buildCategorySection(provider),
              FilterChipRow(
                labels: AppData.filters,
                selectedIndex: provider.selectedFilterIndex,
                onSelected: provider.selectFilter,
              ),
              _buildProductGrid(context, provider, leftProducts, rightProducts),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(StringConst.homeWelcome.toUpperCase(), style: AppTextStyles.homeWelcome,),
              Text(StringConst.homeUserName.toUpperCase(), style: AppTextStyles.homeUserName,),
            ],
          ),
        ),
        Row(
          spacing: NumberConstant.tightSpacing,
          children: [
            CircularIconButton(icon: AssetRes.icSearch, onTap: () {},),
            CircularIconButton(icon: AssetRes.icCart, showBadge: true, onTap: () => context.push(NamedRoutes.wishlist.routeName),),
          ],
        ),
      ],
    );
  }

  Widget _buildHero() {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        children: [
          Align(
              alignment: .topStart,
              child: _buildDiscountBadge(label: StringConst.discount20, angle: -0.8)),
          Expanded(
            child: Padding(
              padding: .symmetric(vertical: NumberConstant.sectionSpacing),
              child: Stack(
                alignment: .bottomCenter,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: StringConst.homeHeroPrefix.toUpperCase(), style: AppTextStyles.homeHeroTitle),
                        TextSpan(text: StringConst.homeHeroHighlight.toUpperCase(), style: AppTextStyles.homeHeroHighlight),
                      ],
                    ),
                    textAlign: .center,
                  ),
                  SvgPicture.asset(AssetRes.icStyleRings),
                ],
              ),
            ),
          ),
          Align(
            alignment: .bottomEnd,
              child: _buildDiscountBadge(label: StringConst.discount20, angle: -0.8)),
      
        ],
      ),
    );
  }

  Widget _buildDiscountBadge({required String label, required double angle}) {
    return Transform.rotate(
      angle: angle,
      child: Stack(
        alignment: .center,
        children: [
          SvgPicture.asset(AssetRes.icDiscountStar),
          Column(
            mainAxisSize: .min,
            children: [
              Text(label, style: AppTextStyles.discountBadge,),
              Text(StringConst.offLabel, style: AppTextStyles.discountOff,),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(HomeProvider provider) {
    return Column(
      spacing: NumberConstant.itemSpacing,
      crossAxisAlignment: .start,
      children: [
        Row(
          spacing: 8,
          children: [
            Text(StringConst.categorySection.toUpperCase(), style: AppTextStyles.sectionTitle,),
            Image.asset(AssetRes.icCategoryFire, width: NumberConstant.categoryFireWidth, height: NumberConstant.categoryFireHeight,),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: NumberConstant.categoryGap,
            children: [
              for (var i = 0; i < AppData.categories.length; i++)
                _buildCategoryItem(category: AppData.categories[i], selected: provider.selectedCategoryIndex == i, onTap: () => provider.selectCategory(i),),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem({required CategoryModel category, required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: NumberConstant.categoryItemWidth,

        child: Column(
              spacing: NumberConstant.tightSpacing,
              children: [
                Container(
                  width: NumberConstant.categoryAvatarSize,
                  height: NumberConstant.categoryAvatarSize,
                  decoration: BoxDecoration(
                      shape: .circle,
                      border: Border.all(color: selected ? AppColors.accent : Colors.transparent, width: 2),
                    image: DecorationImage(image: AssetImage(category.image,), fit: .cover)
                  ),

                ),
                Text(category.name.toUpperCase(), style: selected ? AppTextStyles.categoryLabelSelected : AppTextStyles.categoryLabel, textAlign: .center, maxLines: 1, overflow: .ellipsis,),
              ],
            ),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, HomeProvider provider, List<ProductModel> leftProducts, List<ProductModel> rightProducts) {
    return Row(
      spacing: NumberConstant.productGridGap,
      crossAxisAlignment: .start,
      children: [
        Expanded(child: _buildProductColumn(context, provider, leftProducts)),
        Expanded(
          child: Padding(
            padding: .only(top: NumberConstant.productGridStagger),
            child: _buildProductColumn(context, provider, rightProducts),
          ),
        ),
      ],
    );
  }

  Widget _buildProductColumn(BuildContext context, HomeProvider provider, List<ProductModel> products) {
    return Column(
      spacing: NumberConstant.productGridGap,
      children: [
        for (final product in products)
          AspectRatio(
            aspectRatio: NumberConstant.productCardAspectRatio,
            child: ProductGridCard(
              product: product,
              isFavorite: provider.isFavorite(product.id),
              onFavoriteTap: () => provider.toggleFavorite(product.id),
              onTap: () => context.push(NamedRoutes.productDetails.detailsPath(product.id)),
              onActionTap: () => context.push(NamedRoutes.productDetails.detailsPath(product.id)),
            ),
          ),
      ],
    );
  }
}
