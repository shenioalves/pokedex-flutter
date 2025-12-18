class PokemonModel {
  final String name;
  final String url;

  final String? _explicitId;

  final int? height;
  final int? weight;
  final List<String>? types;
  final List<PokemonStat>? stats;

  PokemonModel({
    required this.name,
    required this.url,
    String? id,
    this.height,
    this.weight,
    this.types,
    this.stats,
  }) : _explicitId = id;

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(name: json['name'] ?? '', url: json['url'] ?? '');
  }

  factory PokemonModel.fromDetailsJson(Map<String, dynamic> json) {
    return PokemonModel(
      url: '',
      name: json['name'] ?? '',

      id: json['id']?.toString() ?? '0',

      types:
          (json['types'] as List?)
              ?.map((t) => t['type']['name'] as String)
              .toList() ??
          [],

      height: json['height'],
      weight: json['weight'],

      stats:
          (json['stats'] as List?)
              ?.map(
                (s) =>
                    PokemonStat(name: s['stat']['name'], value: s['base_stat']),
              )
              .toList() ??
          [],
    );
  }

  String get id {
    if (_explicitId != null && _explicitId != '0') {
      return _explicitId;
    }

    try {
      if (url.isNotEmpty) {
        final cleanUrl = url.endsWith('/')
            ? url.substring(0, url.length - 1)
            : url;
        return cleanUrl.split('/').last;
      }
      return '0';
    } catch (_) {
      return '0';
    }
  }

  String get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
}

class PokemonStat {
  final String name;
  final int value;

  PokemonStat({required this.name, required this.value});
}
