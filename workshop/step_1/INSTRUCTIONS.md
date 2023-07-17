
# Step 1: State

This folder contains the **state** component of the Pokedex bloc.

- `pokedex_state.dart`: Contains the possibile states our feature can assume
    - `LoadingState`: Rapresent a state in which data are not availble because we are fetching them
    - `ErrorState`: Rapresent a state in which some error has appened
    - `LoadedState`: Rapresent a state in which data availble and we want the user to interact with them

We are going to replace the `lib/pokedex/bloc/pokedex_state.dart` content with the content of this file, and then discuss it.