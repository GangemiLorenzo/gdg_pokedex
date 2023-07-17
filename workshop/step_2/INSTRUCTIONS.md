
# Step 2: Events

This folder contains the **Event** component of the Pokedex bloc.

- `pokedex_event.dart`: Contains the possibile events that our feature can trigger
    - `FetchPokedexEvent`: This event tells the bloc that we want to fetch the data from the APIs
    - `FetchMorePokedexEvent`: When the bottom of the available data is reached, we want ot fetch more
    - `CatchPokemonEvent`: Tells the bloc that we have catched a specific pokemon

We are going to replace the `lib/pokedex/bloc/pokedex_event.dart` content with the content of this file, and then discuss it.