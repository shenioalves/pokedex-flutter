import 'package:flutter/material.dart';
import 'package:pokedex/app/model/pokemon_model.dart';
import 'pokedex_tile_widget.dart';

class PokedexListWidget extends StatelessWidget {
  final List<PokemonModel> pokemons;
  final String? currentFilterType;

  const PokedexListWidget({
    super.key,
    required this.pokemons,
    this.currentFilterType,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: pokemons.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return PokedexTileWidget(
          pokemon: pokemon,
          currentFilterType: currentFilterType,
        );
      },
    );
  }
}