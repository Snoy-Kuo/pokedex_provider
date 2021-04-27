import 'package:flutter/material.dart';
import 'package:pokedex_provider/scoped_models/pokelist_notifier.dart';
import 'package:pokedex_provider/screens/detail/pokemonDetailPage.dart';
import 'package:pokedex_provider/screens/list/pokemon_list.dart';
import 'package:provider/provider.dart';

import 'common/repository/repository.dart';
import 'common/route/routes.dart';
import 'common/theme/theme.dart';
import 'scoped_models/pokedetail_notifier.dart';

class App extends StatelessWidget {
  final Repository repository;

  App({required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokeListNotifier(repository: repository)..loadDex(),
        ),
        ChangeNotifierProvider(
          create: (_) => PokeDetailNotifier(repository: repository),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        title: 'Pokedex Provider',
        routes: {
          AppRoutes.home: (context) => PokemonListScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name!.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'detail') {
            var name = pathElements[2];
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => PokemonDetailPage(
                      name: name,
                    ));
          }
          return null;
        },
      ),
    );
  }
}
