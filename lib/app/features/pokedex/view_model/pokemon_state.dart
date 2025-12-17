import 'package:equatable/equatable.dart';
import 'package:pokedex/app/model/pokemon_model.dart';

abstract class PokemonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<PokemonModel> filteredPokemons;
  final List<PokemonModel> allPokemons;

  final String? currentType;

  PokemonLoadedState({required this.allPokemons, required this.filteredPokemons, this.currentType});

  // Facilita criar um novo estado mudando só o que precisa
  PokemonLoadedState copyWith({
    List<PokemonModel>? allPokemons,
    List<PokemonModel>? filteredPokemons,
    String? currentType,
  }) {
    return PokemonLoadedState(
      allPokemons: allPokemons ?? this.allPokemons,
      filteredPokemons: filteredPokemons ?? this.filteredPokemons,
      currentType: currentType ?? this.currentType,
    );
  }

  @override
  List<Object?> get props => [allPokemons, filteredPokemons, currentType];
}

class PokemonErrorState extends PokemonState {
  final String message;
  PokemonErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
