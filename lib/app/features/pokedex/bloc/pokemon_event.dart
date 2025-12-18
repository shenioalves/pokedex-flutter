import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPokemonsEvent extends PokemonEvent {}
class SearchPokemonEvent extends PokemonEvent {
  final String query;

  SearchPokemonEvent(this.query);

  @override
  List<Object> get props => [query];
}

class FilterTypeEvent extends PokemonEvent {
  final String? type;

  FilterTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}
