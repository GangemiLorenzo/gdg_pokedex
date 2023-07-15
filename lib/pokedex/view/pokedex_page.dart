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
          builder: (context, state) => switch (state) {
            (LoadingState _) => const PokedexLoading(),
            (ErrorState errorState) => PokedexError(
                state: errorState,
              ),
            (LoadedState loadedState) => PokedexContent(
                state: loadedState,
              ),
            _ => Container(),
          },
        ),
      ),
    );
  }
}
