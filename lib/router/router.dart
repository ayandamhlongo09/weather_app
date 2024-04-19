import 'package:go_router/go_router.dart';
import 'package:weather_app/components/bottom_nav_bar.dart';
import 'package:weather_app/pages/favorites.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/pages/splash.dart';

class AppRoutes {
  static const String splash = "splash";
  static const String home = "home";
  static const String favorites = "favorites";
  static const String nav = "nav";

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: nav,
        path: "/nav",
        builder: (context, state) => const BottomNavBar(),
      ),
      GoRoute(
        name: splash,
        path: "/",
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: favorites,
        path: "/favorites",
        builder: (context, state) => const FavoritesPage(),
      ),
      GoRoute(
        name: home,
        path: "/home",
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
