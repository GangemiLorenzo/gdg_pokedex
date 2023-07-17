# Step 5: Widgets

At the end of this step we are going to have a completed working Pokedex app that interact with our bloc and state.


More specifically we are seeing the:
- `BlocProvider.of<PokedexBloc>(context)`: Allows to get the bloc instance that has previously been injected by the `BlocProvider` in `pokedex_page.dart`
- `.add(Event())`: Method of the bloc that takes care of adding an event, which will be received by `pokedex_bloc.dart`.
- `state`: This variable has been provided by the `BlocBuilder` and contains the current state informations and data. We are going to read from it and fill our widgets with data.


We can add the following files directly under the `lib/pokedex/view/` folder. Then we can discuss.
- `pokedex_content.dart`
- `pokedex_error.dart`
- `pokedex_loading.dart`
- `pokemon_widget.dart`