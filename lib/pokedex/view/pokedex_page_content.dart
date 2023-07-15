import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdg_pokedex/pokedex/bloc/pokedex_bloc.dart';
import 'package:gdg_pokedex/pokedex/model/pokemon_model.dart';

class PokedexPageContent extends StatelessWidget {
  final LoadedState state;

  const PokedexPageContent({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        controller: ScrollController()..addListener(() {}),
        itemCount: state.pokemonList.length + (state.isLoading ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index >= state.pokemonList.length - 1 && !state.isLoading) {
            BlocProvider.of<PokedexBloc>(context).add(FetchOtherPokedexEvent());
          }
          if (index == state.pokemonList.length) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            );
          }

          return PokemonWidget(
            pokemon: state.pokemonList[index],
            isCatched: state.catchedPokemonList.contains(
              state.pokemonList[index].index,
            ),
          );
        },
      ),
    );
  }
}

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
      color: Theme.of(context).colorScheme.primaryContainer,
      elevation: isCatched ? 4 : 0,
      child: InkWell(
        onTap: () => {
          BlocProvider.of<PokedexBloc>(context).add(
            CatchPokemonEvent(
              id: pokemon.index,
            ),
          ),
        },
        child: Row(
          children: [
            const SizedBox(width: 10.0),
            Image.network(
              pokemon.spriteUrl,
              width: 80,
              height: 80,
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
              Icon(
                Icons.check,
                color: pokemon.color,
              ),
          ],
        ),
      ),
    );
  }
}
