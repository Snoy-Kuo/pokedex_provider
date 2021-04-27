import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex_provider/scoped_models/pokedetail_notifier.dart';
import 'package:pokedex_provider/utils/colorTheme.dart';
import 'package:pokedex_provider/widgets/customWidget.dart';
import 'package:provider/provider.dart';

class Moves extends StatelessWidget {
  final String? type;

  const Moves({this.type});

  @override
  Widget build(BuildContext context) {
    log('Moves build');
    return _moves(context);
  }

  Widget _moves(BuildContext context) {
    final state = Provider.of<PokeDetailNotifier>(context, listen: false);
    if (state.pokemonDetail == null || state.pokemonDetail!.moves.length == 0) {
      return Container(
        child: Center(
          child: Text('No information available'),
        ),
      );
    }
    List<Widget> moves = state.pokemonDetail!.moves
        .map((f) => Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: setPrimaryColor(type).withAlpha(150),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 2),
                      color: setPrimaryColor(type).withAlpha(150),
                      spreadRadius: 0),
                ],
              ),
              child: Text(
                f.move.name,
                style: TextStyle(
                    fontSize: getFontSize(context, 15),
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ))
        .toList();

    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Wrap(alignment: WrapAlignment.spaceBetween, children: moves)),
    );
  }
}
