import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/features/pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/app/model/pokemon_model.dart';


abstract class FavoritesListState {}

class FavoritesListInitial extends FavoritesListState {}

class FavoritesListLoading extends FavoritesListState {}

class FavoritesListSuccess extends FavoritesListState {
  final List<PokemonModel> pokemons;
  FavoritesListSuccess(this.pokemons);
}

class FavoritesListError extends FavoritesListState {}

class FavoritesListCubit extends Cubit<FavoritesListState> {
  final PokemonRepository repository;

  FavoritesListCubit(this.repository) : super(FavoritesListInitial());

  Future<void> loadFavorites(List<String> ids) async {

    final validIds = ids.where((id) => id != '0' && id.isNotEmpty).toList();

    if (validIds.isEmpty) {
      emit(FavoritesListSuccess([]));
      return;
    }

    emit(FavoritesListLoading());

    try {

      final requests = validIds.map((id) => repository.getPokemonDetail(id));

      final pokemons = await Future.wait(requests);

      emit(FavoritesListSuccess(pokemons));
    } catch (e) {
   
      emit(FavoritesListError());
    }
  }
}
