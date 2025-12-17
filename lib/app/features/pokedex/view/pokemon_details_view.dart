import 'package:flutter/material.dart';
import 'package:pokedex/app/theme/app_colors.dart';

class PokemonDetailsView extends StatelessWidget {
  final String id;
  final String? type; // Recebemos o tipo para definir a cor de fundo

  const PokemonDetailsView({
    super.key, 
    required this.id, 
    this.type, // Pode ser null
  });

  @override
  Widget build(BuildContext context) {
    // Definimos a cor
    final backgroundColor = AppColors.getColorByType(type);

    return Scaffold(
      backgroundColor: backgroundColor, // Fundo com a cor do tipo
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparente para ver o fundo
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pokémon #$id', 
              style: const TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold, 
                color: Colors.white
              ),
            ),
            if (type != null)
              Text(
                'Tipo: ${type!.toUpperCase()}',
                style: const TextStyle(color: Colors.white70, fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}