import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/features/pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/app/model/pokemon_model.dart';

abstract class PokemonDetailsState {}
class PokemonDetailsLoading extends PokemonDetailsState {}
class PokemonDetailsError extends PokemonDetailsState {
  final String message;
  PokemonDetailsError(this.message);
}
class PokemonDetailsSuccess extends PokemonDetailsState {
  final PokemonModel pokemon;
  PokemonDetailsSuccess(this.pokemon);
}

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  final PokemonRepository repository;

  PokemonDetailsCubit(this.repository) : super(PokemonDetailsLoading());

  Future<void> getPokemonDetails(String id) async {
    emit(PokemonDetailsLoading());
    try {
      final pokemon = await repository.getPokemonDetail(id);
      emit(PokemonDetailsSuccess(pokemon));
    } catch (e) {
      emit(PokemonDetailsError("Erro ao carregar detalhes"));
    }
  }
}