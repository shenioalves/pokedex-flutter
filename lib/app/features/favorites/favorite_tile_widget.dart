import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/model/pokemon_model.dart';
import 'package:pokedex/app/theme/app_colors.dart';

class FavoriteTileWidget extends StatelessWidget {
  final PokemonModel pokemon;

  const FavoriteTileWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final type = pokemon.types != null && pokemon.types!.isNotEmpty
        ? pokemon.types!.first
        : null;
    final color = AppColors.getColorByType(type);

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'details',
          pathParameters: {'id': pokemon.id},
          queryParameters: {'type': type, 'name': pokemon.name},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Hero(
                tag: pokemon.id,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CachedNetworkImage(
                    imageUrl: pokemon.imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (_, __, ___) =>
                        Icon(Icons.catching_pokemon, size: 40, color: color),
                  ),
                ),
              ),
            ),

            Text(
              pokemon.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: color,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
