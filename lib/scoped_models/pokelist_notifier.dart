import 'package:flutter/widgets.dart';
import 'package:pokedex_provider/common/model/pokedex.dart';
import 'package:pokedex_provider/common/repository/abstract_repository.dart';

class PokeListNotifier extends ChangeNotifier {
  final Repository repository;

  PokeListNotifier({required this.repository});

  Pokedex? _pokedex;

  Pokedex? get pokedex => _pokedex;

  List<PokemonEntryModel>? get pokemonList {
    if (_pokedex != null) {
      return _pokedex!.pokemonEntries;
    } else {
      return null;
    }
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future loadDex() {
    _isLoading = true;
    notifyListeners();

    if (null != pokedex) {
      return Future.delayed(Duration.zero).then((_) {
        _isLoading = false;
        notifyListeners();
      });
    }
    return repository.loadDex().then((loaded) {
      _pokedex = loaded;
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }
}
