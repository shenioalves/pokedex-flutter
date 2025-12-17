import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/features/pokedex/view/widgets/pokedex_tile_widget.dart';
import 'package:pokedex/app/features/pokedex/view_model/pokemon_bloc.dart';
import 'package:pokedex/app/features/pokedex/view_model/pokemon_state.dart';

class PokedexListSection extends StatelessWidget {
  const PokedexListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PokemonErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is PokemonLoadedState) {
          if (state.filteredPokemons.isEmpty) {
            return const Center(
              child: Text('Nenhum Pokémon encontrado'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.filteredPokemons.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final pokemon = state.filteredPokemons[index];

              return PokemonTileWidget(
                pokemon: pokemon,
                currentFilterType: state.currentType,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
