import 'dart:convert';

import 'package:pokedex/app/core/api/i_api_client.dart';
import 'package:pokedex/app/model/pokemon_model.dart';

class PokemonRepository {
  final ApiClient api;

  PokemonRepository(this.api);

  Future<List<PokemonModel>> getPokemons({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await api.get(
        endpoint: 'pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      var rawData = response.data;
      if (rawData is String) {
        rawData = jsonDecode(rawData);
      }

      final List results = rawData['results'];

      return results.map((e) => PokemonModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PokemonModel>> getPokemonsByType(String type) async {
    try {
      final response = await api.get(endpoint: 'type/${type.toLowerCase()}');

      var rawData = response.data;
      if (rawData is String) rawData = jsonDecode(rawData);

      final List pokemonList = rawData['pokemon'];

      return pokemonList.map((item) {
        return PokemonModel.fromJson(item['pokemon']);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<PokemonModel> getPokemonDetail(String id) async {
    try {
      final response = await api.get(endpoint: 'pokemon/$id');

      var rawData = response.data;
      if (rawData is String) rawData = jsonDecode(rawData);

      return PokemonModel.fromDetailsJson(rawData);
    } catch (e) {
      rethrow;
    }
  }
}
