import 'package:flutter/material.dart';

class PokedexPageLoading extends StatelessWidget {
  const PokedexPageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[CircularProgressIndicator()],
      ),
    );
  }
}
