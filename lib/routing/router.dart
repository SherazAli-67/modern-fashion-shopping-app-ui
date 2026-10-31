import 'package:go_router/go_router.dart';
import 'package:modern_shopping_app_ui/presentation/screens/splash_screen.dart';

GoRouter router = GoRouter(
    initialLocation: NamedRoutes.splash.routeName,
    routes: [
      GoRoute(path: NamedRoutes.splash.routeName, builder: (ctx, state) => SplashScreen())
    ],
);

enum NamedRoutes {
  splash('/splash');
  
  final String routeName;
  const NamedRoutes(this.routeName);
}