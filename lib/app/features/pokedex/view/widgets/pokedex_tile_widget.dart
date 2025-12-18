import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/model/pokemon_model.dart';
import 'package:pokedex/app/theme/app_colors.dart';

class PokedexTileWidget extends StatelessWidget {
  final PokemonModel pokemon;
  final String? currentFilterType;

  const PokedexTileWidget({
    super.key,
    required this.pokemon,
    required this.currentFilterType,
  });

  @override
  Widget build(BuildContext context) {
    String? typeToUse = currentFilterType;

    if (typeToUse == null &&
        pokemon.types != null &&
        pokemon.types!.isNotEmpty) {
      typeToUse = pokemon.types!.first;
    }
    final backgroundColor = AppColors.getColorByType(typeToUse);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.4),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: SizedBox(
          width: 60,
          height: 60,
          child: Hero(
            tag: pokemon.id,
            child: pokemon.id == '0'
                ? const Icon(Icons.help_outline)
                : CachedNetworkImage(
                    imageUrl: pokemon.imageUrl,
                    placeholder: (_, __) => const CircularProgressIndicator(),
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                  ),
          ),
        ),
        title: Text(
          pokemon.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        //subtitle: Text('#${pokemon.id}'),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          context.goNamed(
            'details',
            pathParameters: {'id': pokemon.id},
            queryParameters: {
              if (currentFilterType != null) 'type': currentFilterType,
              'name': pokemon.name, 
            },
          );
        },
      ),
    );
  }
}
