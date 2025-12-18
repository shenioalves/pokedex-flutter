import 'package:get_it/get_it.dart';
import 'package:pokedex/app/core/api/dio_api_client.dart';
import 'package:pokedex/app/core/api/i_api_client.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_bloc.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_details_cubit.dart';
import 'package:pokedex/app/features/pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/app/features/favorites/favorite_cubit.dart';
import 'package:pokedex/app/features/favorites/favorites_list_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ApiClient>(() => DioApiClientImp());

  getIt.registerLazySingleton(() => PokemonRepository(getIt<ApiClient>()));

  getIt.registerFactory(() => PokemonBloc(getIt<PokemonRepository>()));

  getIt.registerFactory(() => PokemonDetailsCubit(getIt<PokemonRepository>()));

  getIt.registerSingleton<FavoriteCubit>(FavoriteCubit());

  getIt.registerFactory<FavoritesListCubit>(
    () => FavoritesListCubit(getIt<PokemonRepository>()),
  );
}
