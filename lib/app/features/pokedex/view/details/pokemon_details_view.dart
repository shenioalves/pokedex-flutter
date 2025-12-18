import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/app/features/pokedex/bloc/pokemon_details_cubit.dart';
import 'package:pokedex/app/features/favorites/favorite_cubit.dart';
import 'package:pokedex/app/theme/app_colors.dart';

class PokemonDetailsView extends StatelessWidget {
  final String id;
  final String? type;
  final String? name;

  const PokemonDetailsView({super.key, required this.id, this.type, this.name});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I<PokemonDetailsCubit>()..getPokemonDetails(id),
        ),
        BlocProvider.value(value: GetIt.I<FavoriteCubit>()),
      ],
      child: Scaffold(
        body: BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
          builder: (context, state) {
            String? currentType = type;
            if (state is PokemonDetailsSuccess && state.pokemon.types != null) {
              if (state.pokemon.types!.isNotEmpty) {
                currentType = state.pokemon.types!.first;
              }
            }
            final backgroundColor = AppColors.getColorByType(currentType);

            return Stack(
              children: [
                Container(color: backgroundColor),

                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                Positioned(
                  top: 100,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (name ?? '').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          BlocBuilder<FavoriteCubit, List<String>>(
                            builder: (context, favoriteList) {
                              final isFav = favoriteList.contains(id);

                              return Material(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black26,
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<FavoriteCubit>()
                                        .toggleFavorite(id);
                                  },
                                  borderRadius: BorderRadius.circular(8),
                                  splashColor: Colors.white.withOpacity(0.8),
                                  highlightColor: backgroundColor.withOpacity(
                                    0.5,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 60,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.catching_pokemon,

                                            color: isFav
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.5),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            isFav ? 'Favorito' : 'Favoritar',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (currentType ?? 'Carregando...').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 60,
                      left: 24,
                      right: 24,
                    ),
                    child: _buildContent(state),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Hero(
                        tag: id,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(PokemonDetailsState state) {
    if (state is PokemonDetailsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is PokemonDetailsError) {
      return Center(child: Text(state.message));
    }

    if (state is PokemonDetailsSuccess) {
      final p = state.pokemon;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('Altura', '${(p.height ?? 0) / 10} m'),
                _buildStatItem('Peso', '${(p.weight ?? 0) / 10} kg'),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Estatísticas Base',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...?p.stats?.map(
              (stat) => _buildProgressBar(
                stat.name,
                stat.value,
                AppColors.getColorByType(p.types?.first),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildProgressBar(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              _formatStatName(label),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            value.toString().padLeft(3, '0'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 200.0,
              backgroundColor: Colors.grey[200],
              color: color,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }

  String _formatStatName(String name) {
    switch (name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SATK';
      case 'special-defense':
        return 'SDEF';
      case 'speed':
        return 'SPD';
      default:
        return name.toUpperCase();
    }
  }
}
