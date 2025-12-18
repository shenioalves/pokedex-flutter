import 'package:go_router/go_router.dart';
import 'package:pokedex/app/features/favorites/favorites_view.dart';
import 'package:pokedex/app/features/home/pokedex_view.dart';
import 'package:pokedex/app/features/pokedex/view/details/pokemon_details_view.dart';
import 'package:pokedex/app/features/splash/splash_view.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',

  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashView()),

    GoRoute(
      path: '/',
      builder: (context, state) => const PokedexView(),
      routes: [
        GoRoute(
          path: 'pokemon/:id',
          name: 'details',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final type = state.uri.queryParameters['type'];
            final name = state.uri.queryParameters['name'];
            return PokemonDetailsView(id: id, type: type, name: name);
          },
        ),
        GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesView(),
    ),
      ],
    ),
  ],
);
