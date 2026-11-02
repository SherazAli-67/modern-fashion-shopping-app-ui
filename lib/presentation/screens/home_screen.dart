import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/constants/number_constant.dart';
import 'package:modern_shopping_app_ui/constants/string_const.dart';
import 'package:modern_shopping_app_ui/core/app_animations.dart';
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

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _badgeController;
  late final Animation<double> _badgeFloat;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: AppAnimations.home,
    )..forward();

    _badgeController = AnimationController(
      vsync: this,
      duration: AppAnimations.badgeFloat,
    )..repeat(reverse: true);

    _badgeFloat = Tween<double>(begin: -3, end: 3).animate(
      CurvedAnimation(parent: _badgeController, curve: AppAnimations.easeInOut),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _badgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final products = provider.filteredProducts;
    final leftProducts = [
      for (var i = 0; i < products.length; i += 2) products[i],
    ];
    final rightProducts = [
      for (var i = 1; i < products.length; i += 2) products[i],
    ];

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .fromLTRB(
            NumberConstant.horizontalPadding,
            NumberConstant.itemSpacing,
            NumberConstant.horizontalPadding,
            NumberConstant.sectionSpacing,
          ),
          child: Column(
            spacing: NumberConstant.sectionSpacing,
            crossAxisAlignment: .stretch,
            children: [
              FadeSlideIn(
                parent: _entranceController,
                begin: 0,
                end: 0.35,
                offset: const Offset(0, -0.08),
                child: _buildHeader(context),
              ),
              FadeSlideIn(
                parent: _entranceController,
                begin: 0.12,
                end: 0.5,
                child: _buildHero(),
              ),
              FadeSlideIn(
                parent: _entranceController,
                begin: 0.28,
                end: 0.65,
                child: _buildCategorySection(provider),
              ),
              FadeSlideIn(
                parent: _entranceController,
                begin: 0.4,
                end: 0.75,
                child: FilterChipRow(
                  labels: AppData.filters,
                  selectedIndex: provider.selectedFilterIndex,
                  onSelected: provider.selectFilter,
                ),
              ),
              FadeSlideIn(
                parent: _entranceController,
                begin: 0.52,
                end: 0.95,
                child: AnimatedSwitcher(
                  duration: AppAnimations.normal,
                  switchInCurve: AppAnimations.easeOutCubic,
                  switchOutCurve: AppAnimations.easeOutCubic,
                  child: KeyedSubtree(
                    key: ValueKey(provider.selectedFilterIndex),
                    child: _buildProductGrid(
                      context,
                      provider,
                      leftProducts,
                      rightProducts,
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
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                StringConst.homeWelcome.toUpperCase(),
                style: AppTextStyles.homeWelcome,
              ),
              Text(
                StringConst.homeUserName.toUpperCase(),
                style: AppTextStyles.homeUserName,
              ),
            ],
          ),
        ),
        Row(
          spacing: NumberConstant.tightSpacing,
          children: [
            PressableScale(
              child: CircularIconButton(icon: AssetRes.icSearch, onTap: () {}),
            ),
            PressableScale(
              child: CircularIconButton(
                icon: AssetRes.icCart,
                showBadge: true,
                onTap: () => context.push(NamedRoutes.wishlist.routeName),
              ),
            ),
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
            child: _buildDiscountBadge(
              label: StringConst.discount20,
              angle: -0.8,
            ),
          ),
          Expanded(
            child: Padding(
              padding: .symmetric(vertical: NumberConstant.sectionSpacing),
              child: Stack(
                alignment: .bottomCenter,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: StringConst.homeHeroPrefix.toUpperCase(),
                          style: AppTextStyles.homeHeroTitle,
                        ),
                        TextSpan(
                          text: StringConst.homeHeroHighlight,
                          style: AppTextStyles.homeHeroHighlight,
                        ),
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
            child: _buildDiscountBadge(
              label: StringConst.discount20,
              angle: -0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountBadge({required String label, required double angle}) {
    return AnimatedBuilder(
      animation: _badgeFloat,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _badgeFloat.value),
          child: Transform.rotate(
            angle: angle + (_badgeFloat.value * 0.01),
            child: child,
          ),
        );
      },
      child: Stack(
        alignment: .center,
        children: [
          SvgPicture.asset(AssetRes.icDiscountStar),
          Column(
            mainAxisSize: .min,
            children: [
              Text(label, style: AppTextStyles.discountBadge),
              Text(StringConst.offLabel, style: AppTextStyles.discountOff),
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
            Text(
              StringConst.categorySection.toUpperCase(),
              style: AppTextStyles.sectionTitle,
            ),
            Image.asset(
              AssetRes.icCategoryFire,
              width: NumberConstant.categoryFireWidth,
              height: NumberConstant.categoryFireHeight,
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: NumberConstant.categoryGap,
            children: [
              for (var i = 0; i < AppData.categories.length; i++)
                _buildCategoryItem(
                  category: AppData.categories[i],
                  selected: provider.selectedCategoryIndex == i,
                  onTap: () => provider.selectCategory(i),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem({
    required CategoryModel category,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return PressableScale(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: NumberConstant.categoryItemWidth,
          child: Column(
            spacing: NumberConstant.tightSpacing,
            children: [
              AnimatedContainer(
                duration: AppAnimations.normal,
                curve: AppAnimations.easeInOut,
                width: NumberConstant.categoryAvatarSize,
                height: NumberConstant.categoryAvatarSize,
                decoration: BoxDecoration(
                  shape: .circle,
                  border: Border.all(
                    color: selected ? AppColors.accent : Colors.transparent,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: AssetImage(category.image),
                    fit: .cover,
                  ),
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: AppAnimations.normal,
                curve: AppAnimations.easeInOut,
                style: selected
                    ? AppTextStyles.categoryLabelSelected
                    : AppTextStyles.categoryLabel,
                child: Text(
                  category.name.toUpperCase(),
                  textAlign: .center,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(
    BuildContext context,
    HomeProvider provider,
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
    HomeProvider provider,
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
                isFavorite: provider.isFavorite(products[i].id),
                onFavoriteTap: () => provider.toggleFavorite(products[i].id),
                onTap: () => context.push(
                  NamedRoutes.productDetails.detailsPath(products[i].id),
                ),
                onActionTap: () => context.push(
                  NamedRoutes.productDetails.detailsPath(products[i].id),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
