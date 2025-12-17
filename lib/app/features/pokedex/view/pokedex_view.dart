import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/app/features/pokedex/view/pokedex_scaffold/_pokedex_scaffold.dart';

import '../view_model/pokemon_bloc.dart';
import '../view_model/pokemon_event.dart';

class PokedexView extends StatelessWidget {
  const PokedexView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<PokemonBloc>()..add(LoadPokemonsEvent()),
      child: const PokedexScaffold(),
    );
  }
}
