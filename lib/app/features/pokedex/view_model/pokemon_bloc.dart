import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/pokemon_repository.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository;

  PokemonBloc(this.repository) : super(PokemonInitialState()) {
    on<LoadPokemonsEvent>(_onLoadPokemons);
    on<SearchPokemonEvent>(_onSearchPokemon);
    on<FilterTypeEvent>(_onFilterType);
  }

  // 1. Carrega os dados da API
  Future<void> _onLoadPokemons(
    LoadPokemonsEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(PokemonLoadingState());
    try {
      final pokemons = await repository.getPokemons();
      // No início, a lista filtrada é igual à lista completa
      emit(
        PokemonLoadedState(allPokemons: pokemons, filteredPokemons: pokemons),
      );
    } catch (e) {
      emit(PokemonErrorState("Falha ao carregar dados"));
    }
  }

  // 2. Lógica da Busca
  void _onSearchPokemon(SearchPokemonEvent event, Emitter<PokemonState> emit) {
    final state = this.state;
    // Só podemos filtrar se já estivermos no estado Loaded
    if (state is PokemonLoadedState) {
      final query = event.query.toLowerCase();

      // Filtramos a lista ORIGINAL (allPokemons)
      final filteredList = state.allPokemons.where((pokemon) {
        return pokemon.name.toLowerCase().contains(query);
      }).toList();

      // Emitimos o novo estado atualizando apenas a lista filtrada
      emit(state.copyWith(filteredPokemons: filteredList));
    }
  }

  // 3. Lógica do Filtro de Tipo
  void _onFilterType(FilterTypeEvent event, Emitter<PokemonState> emit) {
    final state = this.state;
    if (state is PokemonLoadedState) {
      // ⚠️ AVISO TÉCNICO:
      // A lista da API '/pokemon' NÃO traz o tipo (fire, water).
      // Para isso funcionar de verdade, você precisaria buscar os detalhes de cada um.
      // Por enquanto, vou apenas salvar o tipo no estado para a UI reagir (ficar vermelho).

      emit(state.copyWith(currentType: event.type));
    }
  }
}
