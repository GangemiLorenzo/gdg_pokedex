part of 'pokedex_bloc.dart';

abstract class PokedexEvent {}

class FetchPokedexEvent implements PokedexEvent {
  FetchPokedexEvent();
}

class FetchMorePokedexEvent implements PokedexEvent {
  FetchMorePokedexEvent();
}

class CatchPokemonEvent implements PokedexEvent {
  final int id;

  CatchPokemonEvent({
    required this.id,
  });
}
