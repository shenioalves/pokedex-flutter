import 'package:flutter/material.dart';

class AppColors {
  // Cor padrão (Pokedex Red)
  static const Color primary = Color(0xFFEA5D60);
  
  // Mapa de cores por tipo
  static final Map<String, Color> _typeColors = {
    'fire': const Color(0xFFFA6555),
    'water': const Color(0xFF58ABF6),
    'grass': const Color(0xFF48D0B0),
    'electric': const Color(0xFFFFCE4B),
    'ice': const Color(0xFF98D8D8),
    'psychic': const Color(0xFFF85888),
    'fighting': const Color(0xFFC22E28),
    'poison': const Color(0xFFA33EA1),
    'ground': const Color(0xFFE2BF65),
    'flying': const Color(0xFFA98FF3),
    'bug': const Color(0xFFA6B91A),
    'rock': const Color(0xFFB6A136),
    'ghost': const Color(0xFF735797),
    'dragon': const Color(0xFF6F35FC),
    'dark': const Color(0xFF705746),
    'steel': const Color(0xFFB7B7CE),
    'fairy': const Color(0xFFD685AD),
    'normal': const Color(0xFFA8A77A),
  };

  // Método que recebe a String (ex: "fire") e devolve a Cor
  static Color getColorByType(String? type) {
    if (type == null) return primary;
    
    // Normaliza para lowercase para garantir o match
    return _typeColors[type.toLowerCase()] ?? primary;
  }
}