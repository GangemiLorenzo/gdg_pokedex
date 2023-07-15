import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdg_pokedex/pokedex/bloc/pokedex_bloc.dart';

class PokedexError extends StatelessWidget {
  final ErrorState state;

  const PokedexError({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(state.errorMessage),
          const SizedBox(
            height: 8.0,
          ),
          ElevatedButton.icon(
            onPressed: () => {
              BlocProvider.of<PokedexBloc>(context).add(FetchPokedexEvent()),
            },
            icon: const Icon(
              Icons.repeat,
            ),
            label: const Text('Riprova'),
          )
        ],
      ),
    );
  }
}
