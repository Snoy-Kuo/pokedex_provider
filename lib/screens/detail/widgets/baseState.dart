import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex_provider/common/model/pokemonDetail.dart';
import 'package:pokedex_provider/scoped_models/pokedetail_notifier.dart';
import 'package:pokedex_provider/utils/colorTheme.dart';
import 'package:pokedex_provider/widgets/customWidget.dart';
import 'package:provider/provider.dart';

class BaseState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('BaseState build');
    return SingleChildScrollView(
      child: _baseStateSection(context),
    );
  }

  Widget _baseStateSection(BuildContext context) {
    final state = Provider.of<PokeDetailNotifier>(context, listen: false);
    if (state.pokemonDetail == null) {
      return Container();
    }
    var stats = state.pokemonDetail!.stats;
    var listStates = stats.map((x) => _statesRow(x)).toList();
    var space = SizedBox(
      height: 20,
    );
    listStates.add(space);
    listStates.add(_Abilities(state.pokemonDetail!.abilities));
    listStates.add(_Habitat());
    listStates.add(_Shape());
    listStates.add(_SeenAt());
    listStates.add(_PokemonColor());
    listStates.add(_CaptureRate());

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: listStates,
        ));
  }

  Widget _statesRow(Stat stat) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: _BaseStateProperty(
          stat.stat.name,
          double.parse(stat.baseStat.toString()),
          _getStateColor(stat.stat.name)),
    );
  }

  dynamic _getStateColor(String title) {
    switch (title) {
      case 'speed':
        return setPrimaryColor('Fire');
      case 'special-defence':
        return setPrimaryColor('Grass');
      case 'special-attack':
        return setPrimaryColor('Poison');
      case 'attack':
        return setPrimaryColor('Ice');
      case 'hp':
        return setPrimaryColor('Ground');
    }
  }
}

class _Abilities extends StatelessWidget {
  final List<Ability> abilityList;

  _Abilities(this.abilityList);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: fullWidth(context),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                'Abilities',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: getFontSize(context, 14)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                children: abilityList.map((x) {
                  return Container(
                      child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: customText(x.ability.name,
                              style: TextStyle(
                                  fontSize: getFontSize(context, 14),
                                  color: Colors.black87))));
                }).toList(),
              ),
            )
          ],
        ));
  }
}

class _Shape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PokeDetailNotifier>(context, listen: false);
    if (state.pokemonSpecies == null) {
      return Container();
    }
    return _PropertyRow('Shape', state.pokemonSpecies!.shape.name);
  }
}

class _Habitat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PokeDetailNotifier>(context, listen: false);
    if (state.pokemonSpecies == null) {
      return Container();
    }
    return _PropertyRow('Habitat', state.pokemonSpecies!.habitat.name);
  }
}

class _SeenAt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PokeDetailNotifier>(context, listen: false);
    if (state.pokemonSpecies == null ||
        state.pokemonSpecies!.palParkEncounters.length == 0) {
      return Container();
    }

    return _PropertyRow(
        'Seen At', state.pokemonSpecies!.palParkEncounters.first.area.name);
  }
}

class _PokemonColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PokeDetailNotifier>(context, listen: false);
    if (state.pokemonSpecies == null ||
        state.pokemonSpecies!.palParkEncounters.length == 0) {
      return Container();
    }
    return _PropertyRow('Color', state.pokemonSpecies!.color.name);
  }
}

class _CaptureRate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PokeDetailNotifier>(context, listen: false);
    if (state.pokemonSpecies == null) {
      return Container();
    }
    return _PropertyRow(
        'Capture Rate', state.pokemonSpecies!.captureRate.toString());
  }
}

class _PropertyRow extends StatelessWidget {
  final String title;
  final String value;

  _PropertyRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getFontSize(context, 14)),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                value,
                style: TextStyle(
                    fontSize: getFontSize(context, 14), color: Colors.black87),
              ))
        ],
      ),
    );
  }
}

class _BaseStateProperty extends StatelessWidget {
  final String property;
  final double value;
  final Color color;

  _BaseStateProperty(this.property, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              property,
              style: TextStyle(
                  fontSize: getFontSize(context, 15), color: Colors.black54),
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
                fontSize: getFontSize(context, 15), color: Colors.black),
          ),
        ],
      ),
      LinearProgressIndicator(
        value: value / 100,
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    ]);
  }
}
