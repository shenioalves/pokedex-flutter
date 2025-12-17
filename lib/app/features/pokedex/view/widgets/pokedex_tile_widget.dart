import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../model/pokemon_model.dart';

class PokemonTileWidget extends StatelessWidget {
  final PokemonModel pokemon;
  final String? currentFilterType; // Recebemos o filtro atual da View Pai

  const PokemonTileWidget({
    super.key, 
    required this.pokemon,
    required this.currentFilterType, // <--- Novo parâmetro
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: SizedBox(
          width: 60,
          height: 60,
          child: CachedNetworkImage(
             imageUrl: pokemon.url,
             placeholder: (_,__) => const CircularProgressIndicator(),
             errorWidget: (_,__,___) => const Icon(Icons.error),
          ),
        ),
        title: Text(pokemon.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('#${pokemon.id}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        
        onTap: () {
          // Passamos o ID e o TIPO como Query Parameter na URL
          // Ex: /pokemon/25?type=fire
          context.goNamed(
            'details', 
            pathParameters: {'id': pokemon.id},
            queryParameters: currentFilterType != null ? {'type': currentFilterType} : {},
          );
        },
      ),
    );
  }
}