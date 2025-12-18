import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/features/favorites/favorite_cubit.dart';
import 'package:pokedex/app/features/favorites/favorites_list_cubit.dart';
import 'package:pokedex/app/features/pokedex/view/widgets/pokedex_tile_widget.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.I<FavoriteCubit>()),

        BlocProvider(
          create: (_) {
            final currentIds = GetIt.I<FavoriteCubit>().state;
            return GetIt.I<FavoritesListCubit>()..loadFavorites(currentIds);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Meus Favoritos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocListener<FavoriteCubit, List<String>>(
          listener: (context, stateIds) {
            context.read<FavoritesListCubit>().loadFavorites(stateIds);
          },
          child: BlocBuilder<FavoritesListCubit, FavoritesListState>(
            builder: (context, state) {
              if (state is FavoritesListLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is FavoritesListError) {
                return const Center(child: Text('Erro ao carregar favoritos'));
              }

              if (state is FavoritesListSuccess) {
                if (state.pokemons.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.catching_pokemon_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nenhum Pokémon favorito ainda!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: state.pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = state.pokemons[index];
                    return PokedexTileWidget(
                      pokemon: pokemon,
                      currentFilterType: null,
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
