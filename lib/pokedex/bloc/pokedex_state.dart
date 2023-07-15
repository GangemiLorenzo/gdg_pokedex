part of 'pokedex_bloc.dart';

abstract class PokedexState {}

class LoadingState implements PokedexState {}

class ErrorState implements PokedexState {
  final String errorMessage;

  ErrorState({
    required this.errorMessage,
  });

  ErrorState copyWith({
    String? errorMessage,
  }) {
    return ErrorState(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LoadedState implements PokedexState {
  final List<PokemonModel> pokemonList;
  final List<int> catchedPokemonList;
  final bool isLoading;

  LoadedState({
    required this.pokemonList,
    this.catchedPokemonList = const [],
    this.isLoading = false,
  });

  LoadedState copyWith({
    List<PokemonModel>? pokemonList,
    List<int>? catchedPokemonList,
    bool? isLoading,
  }) {
    return LoadedState(
      pokemonList: pokemonList ?? this.pokemonList,
      catchedPokemonList: catchedPokemonList ?? this.catchedPokemonList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
