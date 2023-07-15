import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdg_pokedex/pokedex/bloc/pokedex_bloc.dart';
import 'package:gdg_pokedex/pokedex/view/pokemon_widget.dart';

class PokedexContent extends StatelessWidget {
  final LoadedState state;

  const PokedexContent({
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
            BlocProvider.of<PokedexBloc>(context).add(FetchMorePokedexEvent());
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
