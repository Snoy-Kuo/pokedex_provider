import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex_provider/scoped_models/pokelist_notifier.dart';
import 'package:provider/provider.dart';

import '../../widgets/customWidget.dart';
import 'widgets/pokemonCard.dart';

class PokemonListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('PokemonListPage build');

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: true,
              leading: SizedBox(),
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              floating: false,
              flexibleSpace: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Pokedex',
                  style: TextStyle(
                      fontSize: getFontSize(context, 25),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            _PokemonList()
          ],
        ),
      ),
    );
  }

  @override
  StatelessElement createElement() {
    log('PokemonListPage createElement');
    return super.createElement();
  }
}

class _PokemonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('_PokemonList build');
    final PokeListNotifier state = context.watch<PokeListNotifier>();

    if (state.isLoading && state.pokemonList == null) {
      return SliverGrid.count(
        crossAxisCount: 1,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        children: [
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
    } else if (!state.isLoading && state.pokemonList == null) {
      return SliverGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        children: [Center(child: Text('No pokemon available'))],
      );
    } else {
      return SliverGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.4,
        children: state.pokemonList == null
            ? []
            : state.pokemonList!
                .map(
                  (x) => PokemonCard(
                    model: x,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/detail/${x.pokemonSpecies.name}');
                    },
                  ),
                )
                .toList(),
      );
    }
  }
}
