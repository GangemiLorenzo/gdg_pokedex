import 'dart:convert';

import 'package:gdg_pokedex/pokedex/model/pokemon_model.dart';
import 'package:gdg_pokedex/utils/rest_client.dart';

class PokedexRepo {
  PokedexRepo({
    required this.restClient,
  });

  final RestClient restClient;

  Future<List<PokemonModel>> fetch({
    int? limit,
    int? offset,
  }) async {
    final res = await restClient.get(
      api:
          'https://pokeapi.co/api/v2/pokemon?limit=${limit ?? 10}&offset=${offset ?? 0}',
    );

    final data = json.decode(res.body);

    // Fetch all pokemons concurrently with error handling
    final pokemonRetrieved = <PokemonModel>[];
    final futures = data['results'].map<Future<void>>((p) async {
      try {
        final pRes = await restClient.get(api: p['url']);
        final pokemon = PokemonModel.fromJson(json.decode(pRes.body));
        pokemonRetrieved.add(pokemon);
      } catch (e) {
        throw Exception('Failed to fetch a pokemon: $e');
      }
    }).toList();

    // Wait for all futures to complete
    await Future.wait(futures);

    pokemonRetrieved.sort(
      (a, b) => a.index.compareTo(b.index),
    );

    return pokemonRetrieved;
  }
}
