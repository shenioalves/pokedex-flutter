import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/features/pokedex/view/widgets/pokedex_header_widget.dart';
import 'package:pokedex/app/features/pokedex/view_model/pokemon_bloc.dart';
import 'package:pokedex/app/features/pokedex/view_model/pokemon_event.dart';
import 'package:pokedex/app/features/pokedex/view_model/pokemon_state.dart';

class PokedexHeaderSection extends StatelessWidget {
  const PokedexHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PokemonBloc, PokemonState, String?>(
      selector: (state) =>
          state is PokemonLoadedState ? state.currentType : null,
      builder: (context, currentType) {
        return PokedexHeaderWidget(
          currentType: currentType,

          onSearchChanged: (query) {
            context.read<PokemonBloc>().add(SearchPokemonEvent(query));
          },

          onTypeChanged: (type) {
            context.read<PokemonBloc>().add(FilterTypeEvent(type));
          },
        );
      },
    );
  }
}
