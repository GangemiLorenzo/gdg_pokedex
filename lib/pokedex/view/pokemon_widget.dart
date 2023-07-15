import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdg_pokedex/pokedex/bloc/pokedex_bloc.dart';
import 'package:gdg_pokedex/pokedex/model/pokemon_model.dart';

class PokemonWidget extends StatelessWidget {
  final PokemonModel pokemon;
  final bool isCatched;

  const PokemonWidget({
    super.key,
    required this.pokemon,
    this.isCatched = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: pokemon.color,
      elevation: isCatched ? 4 : 0,
      child: InkWell(
        onTap: () => {
          BlocProvider.of<PokedexBloc>(context).add(
            CatchPokemonEvent(
              id: pokemon.index,
            ),
          ),
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Row(
          children: [
            const SizedBox(width: 10.0),
            Image.network(
              pokemon.spriteUrl,
              width: 80,
              height: 80,
              scale: 1,
            ),
            const SizedBox(width: 10.0),
            Text(
              pokemon.name,
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 10.0),
            if (isCatched)
              const Icon(
                Icons.check,
              ),
          ],
        ),
      ),
    );
  }
}
