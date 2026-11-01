import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/presentation/screens/home_screen.dart';
import 'package:modern_shopping_app_ui/presentation/screens/onboarding_screen.dart';
import 'package:modern_shopping_app_ui/presentation/screens/product_details_screen.dart';
import 'package:modern_shopping_app_ui/presentation/screens/splash_screen.dart';
import 'package:modern_shopping_app_ui/presentation/screens/wishlist_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.splash.routeName,
  routes: [
    GoRoute(path: NamedRoutes.splash.routeName, builder: (ctx, state) => const SplashScreen()),
    GoRoute(path: NamedRoutes.onboarding.routeName, builder: (ctx, state) => const OnboardingScreen()),
    GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => const HomeScreen()),
    GoRoute(path: NamedRoutes.wishlist.routeName, builder: (ctx, state) => const WishlistScreen()),
    GoRoute(
      path: '${NamedRoutes.productDetails.routeName}/:id',
      builder: (ctx, state) => ProductDetailsScreen(productId: state.pathParameters['id']!),
    ),
  ],
);

enum NamedRoutes {
  splash('/splash'),
  onboarding('/onboarding'),
  home('/home'),
  wishlist('/wishlist'),
  productDetails('/product-details');

  final String routeName;
  const NamedRoutes(this.routeName);

  String detailsPath(String id) => '$routeName/$id';
}
