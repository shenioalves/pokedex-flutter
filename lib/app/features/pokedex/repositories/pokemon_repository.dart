import 'dart:convert';  
import 'dart:developer';

import 'package:pokedex/app/core/api/i_api_client.dart';

import '../../../model/pokemon_model.dart';

class PokemonRepository {
  final ApiClient api;

  PokemonRepository(this.api);

  Future<List<PokemonModel>> getPokemons({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await api.get(
        endpoint: '/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );
      var rawData = response.data;
      if (rawData is String) {
        rawData = jsonDecode(rawData);
      }

      final List results = rawData['results'];

      return results.map((e) => PokemonModel.fromJson(e)).toList();
    } catch (e) {
      log('❌ Erro no Repositório: $e');
      rethrow;
    }
  }
}
