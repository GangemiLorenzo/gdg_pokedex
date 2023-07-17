import 'package:bloc/bloc.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

const limit = 20;

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  PokedexBloc(super.initialState);
}
