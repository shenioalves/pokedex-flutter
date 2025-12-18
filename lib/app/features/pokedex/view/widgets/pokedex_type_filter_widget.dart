import 'package:flutter/material.dart';

class PokedexTypeFilterWidget extends StatelessWidget {
  final List<String> types = const [
    'Fire', 'Water', 'Grass', 'Electric', 'Psychic', 
    'Ice', 'Dragon', 'Dark', 'Fairy', 'Normal', 'Fighting', 
    'Poison', 'Ground', 'Flying', 'Bug', 'Rock', 'Ghost', 'Steel'
  ];

  final String? selectedType;
  final ValueChanged<String> onTypeSelected;

  const PokedexTypeFilterWidget({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: types.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = selectedType?.toLowerCase() == type.toLowerCase();

          return GestureDetector(
            onTap: () => onTypeSelected(type.toLowerCase()),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? null
                    : Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: Center(
                child: Text(
                  type,
                  style: TextStyle(
                    color: isSelected ? Colors.red : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}