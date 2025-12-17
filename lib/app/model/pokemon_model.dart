class PokemonModel {
  final String name;
  final String url;

  PokemonModel({required this.name, required this.url});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(name: json['name'] ?? '', url: json['url'] ?? '');
  }

  String get id {
    try {
      if (url.isEmpty) return '0';

      final cleanUrl = url.endsWith('/')
          ? url.substring(0, url.length - 1)
          : url;

      return cleanUrl.split('/').last;
    } catch (e) {
      return '0';
    }
  }

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}
