import 'package:flutter/material.dart';
import 'package:pokedex/app/features/pokedex/view/pokedex_scaffold/pokedex_list_section.dart';

import 'pokedex_header_section.dart';

class PokedexScaffold extends StatelessWidget {
  const PokedexScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Column(
        children: [
          PokedexHeaderSection(),
          Expanded(child: PokedexListSection()),
        ],
      ),
    );
  }
}
