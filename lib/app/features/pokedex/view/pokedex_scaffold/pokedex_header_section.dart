import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_bloc.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_event.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_state.dart';
import 'package:pokedex/app/features/pokedex/view/widgets/pokedex_header_widget.dart';

class PokedexHeaderSection extends StatelessWidget {
  const PokedexHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PokemonBloc, PokemonState, String?>(
      selector: (state) => state.currentType,
      builder: (context, currentType) {
        return PokedexHeaderWidget(
          currentType: currentType,

          onSearchChanged: (query) {
            context.read<PokemonBloc>().add(SearchPokemonEvent(query));
          },

          onTypeChanged: (type) {
            final selected = type.toLowerCase();
            final current = currentType?.toLowerCase();

            final typeToDispatch = (selected == current) ? null : selected;

            debugPrint(
              "Filtro Anterior: $current | Novo Clique: $selected -> Enviando: $typeToDispatch",
            ); 

            context.read<PokemonBloc>().add(FilterTypeEvent(typeToDispatch));
          },
        );
      },
    );
  }
}
