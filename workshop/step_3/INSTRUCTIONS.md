
# Step 3: Bloc logic

This folder contains the **Bloc** component itself.
The content of this element takes care of receiving events, dispatching some logic (usually from repository) and updating the state.


## Step 3.1

We first going to look at the constructor of our bloc.

```dart
  final PokedexRepo pokedexRepo;

  PokedexBloc({
    required this.pokedexRepo,
  }) : super(
          LoadingState(), // Initial State
        ) {
    // Routing of Events to bloc functions
    on<FetchPokedexEvent>(
        (event, emit) async => await _fetchPokedex(event, emit));
    on<FetchMorePokedexEvent>(
        (event, emit) async => await _fetchMorePokedex(event, emit));
    on<CatchPokemonEvent>((event, emit) => _catchPokemon(event, emit));
  }
```

We can move this code into the `lib/pokedex/bloc/pokedex_bloc.dart` file.


## Step 3.2

This is the logic behind the fetching of pokedex data.
This private method is linked with the `FetchPokedexEvent` by the previous seen code.

```dart
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
```


## Step 3.3

Here we have the logic triggered by the `FetchMorePokedex` event.

```dart
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
```


## Step 3.4

And finally the method triggered by the `CatchPokemonEvent` event.

```dart
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
```