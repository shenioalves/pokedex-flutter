import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_bloc.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_event.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_state.dart';
import 'package:pokedex/app/features/pokedex/view/widgets/pokedex_tile_widget.dart';

class PokedexListSection extends StatefulWidget {
  const PokedexListSection({super.key});

  @override
  State<PokedexListSection> createState() => _PokedexListSectionState();
}

class _PokedexListSectionState extends State<PokedexListSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PokemonBloc>().add(LoadPokemonsEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state.status == PokemonStatus.loading &&
            state.allPokemons.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == PokemonStatus.failure &&
            state.allPokemons.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'Erro desconhecido'));
        }

        if (state.status == PokemonStatus.success ||
            (state.status == PokemonStatus.loading &&
                state.allPokemons.isNotEmpty)) {
          if (state.visiblePokemons.isEmpty) {
            return const Center(child: Text('Nenhum Pokémon encontrado'));
          }

          return ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),

            itemCount: state.hasReachedMax
                ? state.visiblePokemons.length
                : state.visiblePokemons.length + 1,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              if (index >= state.visiblePokemons.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final pokemon = state.visiblePokemons[index];
              return PokedexTileWidget(
                pokemon: pokemon,
                currentFilterType: state.currentType,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
