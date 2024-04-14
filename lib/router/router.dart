import 'package:go_router/go_router.dart';
import 'package:weather_app/components/bottom_nav_bar.dart';
import 'package:weather_app/pages/favorites.dart';
import 'package:weather_app/pages/home.dart';

class AppRoutes {
  static const String home = "home";
  static const String favorites = "favorites";
  static const String nav = "nav";

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: nav,
        path: "/",
        builder: (context, state) => const BottomNavBar(),
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
