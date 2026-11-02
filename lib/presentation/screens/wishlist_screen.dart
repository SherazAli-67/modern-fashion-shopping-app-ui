import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_animations.dart';
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

class _WishlistView extends StatefulWidget {
  const _WishlistView();

  @override
  State<_WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<_WishlistView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: AppAnimations.wishlist,
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WishlistProvider>();
    final products = provider.wishlistProducts;
    final leftProducts = [
      for (var i = 0; i < products.length; i += 2) products[i],
    ];
    final rightProducts = [
      for (var i = 1; i < products.length; i += 2) products[i],
    ];

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(
            NumberConstant.horizontalPadding,
            NumberConstant.itemSpacing,
            NumberConstant.horizontalPadding,
            0,
          ),
          child: Column(
            spacing: NumberConstant.itemSpacing,
            crossAxisAlignment: .stretch,
            children: [
              FadeSlideIn(
                parent: _entranceController,
                begin: 0,
                end: 0.4,
                offset: const Offset(0, -0.08),
                child: _buildHeader(context),
              ),
              FadeSlideIn(
                parent: _entranceController,
                begin: 0.15,
                end: 0.55,
                child: FilterChipRow(
                  labels: AppData.wishlistFilters,
                  selectedIndex: provider.selectedFilterIndex,
                  onSelected: provider.selectFilter,
                ),
              ),
              Expanded(
                child: FadeSlideIn(
                  parent: _entranceController,
                  begin: 0.3,
                  end: 0.95,
                  child: AnimatedSwitcher(
                    duration: AppAnimations.normal,
                    switchInCurve: AppAnimations.easeOutCubic,
                    switchOutCurve: AppAnimations.easeOutCubic,
                    child: products.isEmpty
                        ? const Center(
                            key: ValueKey('wishlist-empty'),
                            child: Text(
                              StringConst.wishlistTitle,
                              style: AppTextStyles.sectionTitle,
                            ),
                          )
                        : KeyedSubtree(
                            key: ValueKey(provider.selectedFilterIndex),
                            child: SingleChildScrollView(
                              padding: .only(
                                bottom: NumberConstant.sectionSpacing,
                              ),
                              child: _buildProductGrid(
                                context,
                                provider,
                                leftProducts,
                                rightProducts,
                              ),
                            ),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        PressableScale(
          child: CircularIconButton(
            icon: AssetRes.icArrowBack,
            onTap: () => context.pop(),
          ),
        ),
        Expanded(
          child: Text(
            StringConst.wishlistTitle.toUpperCase(),
            style: AppTextStyles.screenTitle,
            textAlign: .center,
          ),
        ),
        PressableScale(
          child: CircularIconButton(
            icon: AssetRes.icCart,
            showBadge: true,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid(
    BuildContext context,
    WishlistProvider provider,
    List<ProductModel> leftProducts,
    List<ProductModel> rightProducts,
  ) {
    return Row(
      spacing: NumberConstant.productGridGap,
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: _buildProductColumn(context, provider, leftProducts, 0),
        ),
        Expanded(
          child: Padding(
            padding: .only(top: NumberConstant.productGridStagger),
            child: _buildProductColumn(context, provider, rightProducts, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildProductColumn(
    BuildContext context,
    WishlistProvider provider,
    List<ProductModel> products,
    int columnOffset,
  ) {
    return Column(
      spacing: NumberConstant.productGridGap,
      children: [
        for (var i = 0; i < products.length; i++)
          StaggeredFadeSlide(
            index: i * 2 + columnOffset,
            child: AspectRatio(
              aspectRatio: NumberConstant.productCardAspectRatio,
              child: ProductGridCard(
                product: products[i],
                action: .addToCart,
                isFavorite: provider.isFavorite(products[i].id),
                onFavoriteTap: () => provider.toggleFavorite(products[i].id),
                onTap: () => context.push(
                  NamedRoutes.productDetails.detailsPath(products[i].id),
                ),
                onActionTap: () {},
              ),
            ),
          ),
      ],
    );
  }
}
