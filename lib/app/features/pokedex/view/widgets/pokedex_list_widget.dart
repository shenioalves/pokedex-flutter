// lib/app/features/pokedex/view/widgets/pokemon_list.dart
import 'package:flutter/material.dart';
import 'package:pokedex/app/model/pokemon_model.dart';

import 'pokedex_tile_widget.dart';

class PokemonListWidget extends StatelessWidget {
  final List<PokemonModel> pokemons;

  const PokemonListWidget({super.key, required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: pokemons.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return PokemonTileWidget(pokemon: pokemon, currentFilterType: '',);

      },
    );
  }
}
