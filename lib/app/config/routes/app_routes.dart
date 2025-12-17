import 'package:go_router/go_router.dart';
import 'package:pokedex/app/features/pokedex/view/pokedex_view.dart';

import '../../features/pokedex/view/pokemon_details_view.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const PokedexView(),
      routes: [
        GoRoute(
          path: 'pokemon/:id',
          name: 'details',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            // Lendo o parametro opcional '?type='
            final type = state.uri.queryParameters['type'];

            return PokemonDetailsView(id: id, type: type);
          },
        ),
      ],
    ),
  ],
);
