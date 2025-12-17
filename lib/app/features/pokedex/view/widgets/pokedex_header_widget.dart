import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokedex/view/widgets/pokedex_search_bar_widget.dart';
import 'package:pokedex/app/features/pokedex/view/widgets/pokedex_type_filter_widget.dart';
import 'package:pokedex/app/theme/app_colors.dart';


class PokedexHeaderWidget extends StatelessWidget {
  final Function(String) onSearchChanged;
  final Function(String) onTypeChanged;
  final String? currentType;

  const PokedexHeaderWidget({
    super.key,
    required this.onSearchChanged,
    required this.onTypeChanged,
    required this.currentType,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Pega a cor baseada no tipo selecionado (ou a padrão se for null)
    final backgroundColor = AppColors.getColorByType(currentType);

    // Usamos AnimatedContainer para a cor mudar suavemente
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Tempo da animação
      curve: Curves.easeInOut,
      padding: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: backgroundColor, // A COR DINÂMICA ENTRA AQUI
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pokedex',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.catching_pokemon, color: Colors.white, size: 32),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PokemonSearchBarWidget(onChanged: onSearchChanged),
            ),

            const SizedBox(height: 16),

            PokemonTypeFilterWidget(
              selectedType: currentType,
              onTypeSelected: onTypeChanged,
            ),
          ],
        ),
      ),
    );
  }
}