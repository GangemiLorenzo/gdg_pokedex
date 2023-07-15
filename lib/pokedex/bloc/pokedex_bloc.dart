import 'package:bloc/bloc.dart';
import 'package:gdg_pokedex/pokedex/model/pokemon_model.dart';
import 'package:gdg_pokedex/pokedex/repo/pokedex_repo.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

const limit = 20;

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final PokedexRepo pokedexRepo;

  PokedexBloc({
    required this.pokedexRepo,
  }) : super(
          LoadingState(), // Initial State
        ) {
    // Routing of Events to bloc functions
    on<PokedexEvent>((event, emit) async => switch (event) {
          (FetchPokedexEvent fetchPokedexEvent) =>
            await _fetchPokedex(fetchPokedexEvent, emit),
          (FetchMorePokedexEvent fetchMorePokedexEvent) =>
            await _fetchMorePokedex(fetchMorePokedexEvent, emit),
          (CatchPokemonEvent catchPokemonEvent) =>
            _catchPokemon(catchPokemonEvent, emit),
          _ => {},
        });
  }

  /// Contains the logic to handle the [FetchPokedexEvent].
  ///
  /// Emits [LoadingState].
  /// Request pokedex data from [pokedexRepo].
  /// Emits [LoadedState] with data.
  /// If something goes wrong, emits [ErrorState].
  ///
  Future<void> _fetchPokedex(
    FetchPokedexEvent event,
    Emitter<PokedexState> emit,
  ) async {
    try {
      emit(LoadingState());

      final pokedex = await pokedexRepo.fetch(
        limit: limit,
      );
      //await Future.delayed(const Duration(seconds: 3));
      //throw Exception('Prepare for trouble! And make it double!');

      emit(
        LoadedState(
          pokemonList: pokedex,
        ),
      );
    } catch (e) {
      emit(ErrorState(
        errorMessage: e.toString(),
      ));
    }
  }

  /// Contains the logic to handle the [FetchMorePokedexEvent].
  ///
  /// Emits [LoadedState] with [isLoading] property to true.
  /// Request more pokedex data from [pokedexRepo].
  /// Emits [LoadedState] with new data and isLoading to false value.
  /// If something goes wrong, emits [ErrorState].
  ///
  Future<void> _fetchMorePokedex(
    FetchMorePokedexEvent event,
    Emitter<PokedexState> emit,
  ) async {
    final currentState = state as LoadedState;
    try {
      final offset = currentState.pokemonList.length;

      emit(
        currentState.copyWith(isLoading: true),
      );

      final pokedex = await pokedexRepo.fetch(
        limit: limit,
        offset: offset,
      );
      //await Future.delayed(const Duration(seconds: 3));
      //throw Exception('Prepare for trouble! And make it double!');

      emit(
        (state as LoadedState).copyWith(
          pokemonList: [
            ...currentState.pokemonList,
            ...pokedex,
          ],
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(ErrorState(
        errorMessage: e.toString(),
      ));
    }
  }

  /// Contains the logic to handle the [CatchPokemonEvent].
  ///
  /// If the entry is not present in the [catchedPokemonList] list
  /// Then it adds the entry
  /// Otherwise it removes the entry
  /// Finally emits [LoadedState] with updated list.
  /// If something goes wrong, emits [ErrorState].
  ///
  void _catchPokemon(
    CatchPokemonEvent event,
    Emitter<PokedexState> emit,
  ) {
    if (state is! LoadedState) {
      return;
    }

    final currentState = state as LoadedState;

    try {
      final List<int> resultingList =
          List.from(currentState.catchedPokemonList);

      if (!currentState.catchedPokemonList.contains(event.id)) {
        resultingList.add(event.id);
      } else {
        resultingList.remove(event.id);
      }

      emit(
        currentState.copyWith(
          catchedPokemonList: resultingList,
        ),
      );
    } catch (e) {
      emit(ErrorState(
        errorMessage: e.toString(),
      ));
    }
  }
}
