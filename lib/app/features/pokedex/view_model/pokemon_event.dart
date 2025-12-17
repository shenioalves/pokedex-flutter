import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPokemonsEvent extends PokemonEvent {}

// Novo Evento: Usuário digitou na busca
class SearchPokemonEvent extends PokemonEvent {
  final String query;
  SearchPokemonEvent(this.query);

  @override
  List<Object> get props => [query];
}

// Novo Evento: Usuário clicou num tipo (filtro)
class FilterTypeEvent extends PokemonEvent {
  final String? type; // Pode ser null se ele "desmarcar" o filtro
  FilterTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}
