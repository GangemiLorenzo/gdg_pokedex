import 'package:flutter/material.dart';

// Enum for Pokemon types
enum PokemonType {
  normal,
  fire,
  water,
  electric,
  grass,
  ice,
  fighting,
  poison,
  ground,
  flying,
  psychic,
  bug,
  rock,
  ghost,
  dragon,
  dark,
  steel,
  fairy
}

class PokemonModel {
  final int index;
  final String name;
  final String spriteUrl;
  final PokemonType type;

  PokemonModel._({
    required this.index,
    required this.name,
    required this.spriteUrl,
    required this.type,
  });

  // factory constructor to create a Pokemon instance from JSON
  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    late PokemonType type;
    try {
      type = PokemonType.values.byName(
        json['types'].first['type']['name'],
      );
    } catch (_) {
      type = PokemonType.normal;
    }

    return PokemonModel._(
      index: json['id'],
      name: json['name'],
      spriteUrl: json['sprites']['front_default'],
      type: type,
    );
  }

  // Getter for color based on Pokemon type
  Color get color {
    switch (type) {
      case PokemonType.normal:
        return Colors.brown[200]!;
      case PokemonType.fire:
        return Colors.red[200]!;
      case PokemonType.water:
        return Colors.blue[200]!;
      case PokemonType.electric:
        return Colors.yellow[200]!;
      case PokemonType.grass:
        return Colors.green[200]!;
      case PokemonType.ice:
        return Colors.cyan[100]!;
      case PokemonType.fighting:
        return Colors.grey[200]!;
      case PokemonType.poison:
        return Colors.purple[200]!;
      case PokemonType.ground:
        return Colors.brown[200]!;
      case PokemonType.flying:
        return Colors.blue[200]!;
      case PokemonType.psychic:
        return Colors.pink[100]!;
      case PokemonType.bug:
        return Colors.lightGreen[200]!;
      case PokemonType.rock:
        return Colors.grey[400]!;
      case PokemonType.ghost:
        return Colors.deepPurple[200]!;
      case PokemonType.dragon:
        return Colors.indigo[200]!;
      case PokemonType.dark:
        return Colors.black54;
      case PokemonType.steel:
        return Colors.grey[300]!;
      case PokemonType.fairy:
        return Colors.pink[200]!;
      default:
        return Colors.white;
    }
  }
}
