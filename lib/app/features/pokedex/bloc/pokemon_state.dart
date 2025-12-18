import 'package:equatable/equatable.dart';
import 'package:pokedex/app/model/pokemon_model.dart';

enum PokemonStatus { initial, loading, success, failure }

class PokemonState extends Equatable {
  final PokemonStatus status;
  final List<PokemonModel> allPokemons;
  final List<PokemonModel> visiblePokemons;
  final String searchQuery;
  final String? currentType;
  final String? errorMessage;
  
  final bool hasReachedMax; 

  const PokemonState({
    this.status = PokemonStatus.initial,
    this.allPokemons = const [],
    this.visiblePokemons = const [],
    this.searchQuery = '',
    this.currentType,
    this.errorMessage,
    this.hasReachedMax = false, 
  });

  PokemonState copyWith({
    PokemonStatus? status,
    List<PokemonModel>? allPokemons,
    List<PokemonModel>? visiblePokemons,
    String? searchQuery,
    String? currentType,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return PokemonState(
      status: status ?? this.status,
      allPokemons: allPokemons ?? this.allPokemons,
      visiblePokemons: visiblePokemons ?? this.visiblePokemons,
      searchQuery: searchQuery ?? this.searchQuery,
      currentType: currentType ?? this.currentType,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allPokemons,
    visiblePokemons,
    searchQuery,
    currentType,
    errorMessage,
    hasReachedMax,
  ];
}