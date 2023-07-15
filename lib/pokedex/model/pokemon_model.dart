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

  PokemonModel({
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

    return PokemonModel(
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
        return Colors.brown[300]!;
      case PokemonType.fire:
        return Colors.red;
      case PokemonType.water:
        return Colors.blue;
      case PokemonType.electric:
        return Colors.yellow;
      case PokemonType.grass:
        return Colors.green;
      case PokemonType.ice:
        return Colors.cyan[200]!;
      case PokemonType.fighting:
        return Colors.grey;
      case PokemonType.poison:
        return Colors.purple;
      case PokemonType.ground:
        return Colors.brown;
      case PokemonType.flying:
        return Colors.blue[300]!;
      case PokemonType.psychic:
        return Colors.pink[200]!;
      case PokemonType.bug:
        return Colors.lightGreen;
      case PokemonType.rock:
        return Colors.grey[700]!;
      case PokemonType.ghost:
        return Colors.deepPurple;
      case PokemonType.dragon:
        return Colors.indigo;
      case PokemonType.dark:
        return Colors.black;
      case PokemonType.steel:
        return Colors.grey[500]!;
      case PokemonType.fairy:
        return Colors.pink;
      default:
        return Colors.white;
    }
  }
}
