import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdg_pokedex/pokedex/bloc/pokedex_bloc.dart';
import 'package:gdg_pokedex/pokedex/repo/pokedex_repo.dart';
import 'package:gdg_pokedex/pokedex/view/pokedex_content.dart';
import 'package:gdg_pokedex/pokedex/view/pokedex_error.dart';
import 'package:gdg_pokedex/pokedex/view/pokedex_loading.dart';
import 'package:gdg_pokedex/utils/rest_client.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokedexBloc(
        pokedexRepo: PokedexRepo(
          restClient: RestClient(),
        ),
      )..add(
          FetchPokedexEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Pokedex'),
        ),
        body: BlocBuilder<PokedexBloc, PokedexState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const PokedexLoading();
            }

            if (state is ErrorState) {
              return PokedexError(
                state: state,
              );
            }

            if (state is LoadedState) {
              return PokedexContent(
                state: state,
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
