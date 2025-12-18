import 'package:flutter/material.dart';

class PokedexSearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const PokedexSearchBarWidget({super.key, required this.onChanged});

  @override
  State<PokedexSearchBarWidget> createState() => _PokedexSearchBarWidgetState();
}

class _PokedexSearchBarWidgetState extends State<PokedexSearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
      
          hintText: 'Buscar Pokémon...',
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _controller.clear();
              widget.onChanged('');
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
    );
  }
}
