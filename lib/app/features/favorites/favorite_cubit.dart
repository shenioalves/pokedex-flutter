import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoriteCubit extends Cubit<List<String>> {
  FavoriteCubit() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_pokemons') ?? [];
    emit(favorites);
  }

  Future<void> toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = List<String>.from(state);

    if (currentList.contains(id)) {
      currentList.remove(id);
    } else {
      currentList.add(id);
    }

    await prefs.setStringList('favorite_pokemons', currentList);
    emit(currentList);
  }
  
  bool isFavorite(String id) => state.contains(id);
}