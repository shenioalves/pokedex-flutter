import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_event.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_state.dart';
import 'package:pokedex/app/features/pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/app/model/pokemon_model.dart';
import 'package:stream_transform/stream_transform.dart';

// Transformer para evitar spam no scroll (Mantenha se já tiver configurado)
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository;

  PokemonBloc(this.repository) : super(const PokemonState()) {
    on<LoadPokemonsEvent>(
      _onLoadPokemons,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
    on<SearchPokemonEvent>(_onSearchPokemon);
    on<FilterTypeEvent>(_onFilterType);
  }

  // --- 1. Lógica de Carregamento (Scroll Infinito) ---
  Future<void> _onLoadPokemons(
    LoadPokemonsEvent event,
    Emitter<PokemonState> emit,
  ) async {
    // Se tiver um filtro de tipo ativo, o scroll infinito não funciona da mesma forma
    // pois a API de tipo já traz tudo. Então bloqueamos.
    if (state.currentType != null) return;

    if (state.hasReachedMax) return;

    try {
      if (state.status == PokemonStatus.initial) {
        emit(state.copyWith(status: PokemonStatus.loading));
        final pokemons = await repository.getPokemons(offset: 0, limit: 20);
        emit(
          state.copyWith(
            status: PokemonStatus.success,
            allPokemons: pokemons,
            visiblePokemons: pokemons,
            hasReachedMax: false,
          ),
        );
        return;
      }

      final currentLength = state.allPokemons.length;
      final morePokemons = await repository.getPokemons(
        offset: currentLength,
        limit: 20,
      );

      if (morePokemons.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        final updatedList = List.of(state.allPokemons)..addAll(morePokemons);
        // Atualiza tanto allPokemons quanto visiblePokemons (se não tiver busca)
        emit(
          state.copyWith(
            status: PokemonStatus.success,
            allPokemons: updatedList,
            visiblePokemons: state.searchQuery.isEmpty
                ? updatedList
                : _filterList(updatedList, state.searchQuery),
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PokemonStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // --- 2. Lógica do Filtro (CORREÇÃO AQUI) ---
  Future<void> _onFilterType(
    FilterTypeEvent event,
    Emitter<PokemonState> emit,
  ) async {
    // Caso 1: Usuário DESMARCOU o filtro (event.type == null)
    if (event.type == null) {
      emit(state.copyWith(status: PokemonStatus.loading));

      // Resetamos tudo: buscamos a lista normal (página 1) de novo
      try {
        final pokemons = await repository.getPokemons(offset: 0, limit: 20);

        // RECRIAMOS O ESTADO MANUALMENTE para garantir que currentType seja NULL
        // (Isso resolve o bug de "não desmarcar")
        emit(
          PokemonState(
            status: PokemonStatus.success,
            allPokemons: pokemons,
            visiblePokemons: pokemons,
            searchQuery: '', // Limpa a busca também para evitar conflitos
            currentType: null, // <--- FORÇANDO NULL
            hasReachedMax: false,
          ),
        );
      } catch (e) {
        emit(state.copyWith(status: PokemonStatus.failure));
      }
      return;
    }

    // Caso 2: Usuário SELECIONOU um tipo (ex: Fire)
    emit(
      state.copyWith(status: PokemonStatus.loading, currentType: event.type),
    );

    try {
      // Chamamos a nova função do Repositório
      final typePokemons = await repository.getPokemonsByType(event.type!);

      emit(
        state.copyWith(
          status: PokemonStatus.success,
          allPokemons: typePokemons, // Agora a "lista total" é só a desse tipo
          visiblePokemons: typePokemons,
          hasReachedMax:
              true, // API de tipo não tem paginação, então travamos o scroll
          currentType: event.type,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PokemonStatus.failure,
          errorMessage: "Erro ao filtrar tipo",
        ),
      );
    }
  }

  // --- 3. Lógica da Busca ---
  void _onSearchPokemon(SearchPokemonEvent event, Emitter<PokemonState> emit) {
    final query = event.query.toLowerCase();
    final filtered = _filterList(state.allPokemons, query);

    emit(state.copyWith(searchQuery: query, visiblePokemons: filtered));
  }

  // Função auxiliar simples para filtrar lista localmente
  List<PokemonModel> _filterList(List<PokemonModel> list, String query) {
    if (query.isEmpty) return list;
    return list.where((p) => p.name.toLowerCase().contains(query)).toList();
  }
}
