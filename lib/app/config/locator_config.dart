import 'package:get_it/get_it.dart';
import 'package:pokedex/app/core/api/dio_api_client.dart';
import 'package:pokedex/app/core/api/i_api_client.dart';
import 'package:pokedex/app/features/pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/app/features/pokedex/view_model/pokemon_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ApiClient>(() => DioApiClientImp());
  getIt.registerLazySingleton(() => PokemonRepository(getIt<ApiClient>()));

  getIt.registerFactory(() => PokemonBloc(getIt<PokemonRepository>()));
}
