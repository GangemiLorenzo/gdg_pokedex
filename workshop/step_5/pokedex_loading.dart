import 'package:flutter/material.dart';

class PokedexLoading extends StatelessWidget {
  const PokedexLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
