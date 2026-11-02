import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_colors.dart';
import 'package:modern_shopping_app_ui/core/app_data.dart';
import 'package:modern_shopping_app_ui/core/app_textstyles.dart';
import 'package:modern_shopping_app_ui/core/asset_res.dart';
import 'package:modern_shopping_app_ui/core/models/product_model.dart';
import 'package:modern_shopping_app_ui/presentation/providers/wishlist_provider.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/circular_icon_button.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/filter_chip_row.dart';
import 'package:modern_shopping_app_ui/presentation/widgets/product_grid_card.dart';
import 'package:modern_shopping_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WishlistProvider(),
      child: const _WishlistView(),
    );
  }
}

class _WishlistView extends StatelessWidget {
  const _WishlistView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WishlistProvider>();
    final products = provider.wishlistProducts;
    final leftProducts = [for (var i = 0; i < products.length; i += 2) products[i]];
    final rightProducts = [for (var i = 1; i < products.length; i += 2) products[i]];

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.itemSpacing, NumberConstant.horizontalPadding, 0),
          child: Column(
            spacing: NumberConstant.itemSpacing,
            crossAxisAlignment: .stretch,
            children: [
              _buildHeader(context),
              FilterChipRow(
                labels: AppData.wishlistFilters,
                selectedIndex: provider.selectedFilterIndex,
                onSelected: provider.selectFilter,
              ),
              Expanded(
                child: products.isEmpty
                    ? const Center(child: Text(StringConst.wishlistTitle, style: AppTextStyles.sectionTitle,),)
                    : SingleChildScrollView(
                        padding: .only(bottom: NumberConstant.sectionSpacing),
                        child: _buildProductGrid(context, provider, leftProducts, rightProducts),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CircularIconButton(icon: AssetRes.icArrowBack, onTap: () => context.pop(),),
        Expanded(child: Text(StringConst.wishlistTitle.toUpperCase(), style: AppTextStyles.screenTitle, textAlign: .center,),),
        CircularIconButton(icon: AssetRes.icCart, showBadge: true, onTap: () {},),
      ],
    );
  }

  Widget _buildProductGrid(BuildContext context, WishlistProvider provider, List<ProductModel> leftProducts, List<ProductModel> rightProducts) {
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

  Widget _buildProductColumn(BuildContext context, WishlistProvider provider, List<ProductModel> products) {
    return Column(
      spacing: NumberConstant.productGridGap,
      children: [
        for (final product in products)
          AspectRatio(
            aspectRatio: NumberConstant.productCardAspectRatio,
            child: ProductGridCard(
              product: product,
              action: .addToCart,
              isFavorite: provider.isFavorite(product.id),
              onFavoriteTap: () => provider.toggleFavorite(product.id),
              onTap: () => context.push(NamedRoutes.productDetails.detailsPath(product.id)),
              onActionTap: () {},
            ),
          ),
      ],
    );
  }
}
