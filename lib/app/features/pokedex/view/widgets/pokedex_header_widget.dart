import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/app/theme/app_colors.dart';

import 'pokedex_search_bar_widget.dart';
import 'pokedex_type_filter_widget.dart';

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
    final backgroundColor = AppColors.getColorByType(currentType);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.4),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 13,
            spreadRadius: -3,
            offset: const Offset(0, 7),
          ),
          BoxShadow(
            color: backgroundColor.withOpacity(0.2),
            blurRadius: 0,
            spreadRadius: 0,
            offset: const Offset(0, -3),
          ),
        ],
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pokedex',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.push('/favorites');
                      },
                      borderRadius: BorderRadius.circular(8),
                      splashColor: Colors.white.withOpacity(0.8),
                      highlightColor: backgroundColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.catching_pokemon, color: Colors.white),
                            SizedBox(height: 4),
                            Text(
                              'Favoritos',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PokedexSearchBarWidget(onChanged: onSearchChanged),
            ),
            const SizedBox(height: 16),
            PokedexTypeFilterWidget(
              selectedType: currentType,
              onTypeSelected: onTypeChanged,
            ),
          ],
        ),
      ),
    );
  }
}
