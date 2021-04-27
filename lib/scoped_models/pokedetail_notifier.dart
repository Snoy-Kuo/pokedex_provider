import 'package:flutter/widgets.dart';
import 'package:pokedex_provider/common/model/pokemonDetail.dart';
import 'package:pokedex_provider/common/model/pokemonSpecies.dart';
import 'package:pokedex_provider/common/repository/abstract_repository.dart';

class PokeDetailNotifier extends ChangeNotifier {
  final Repository repository;

  PokeDetailNotifier({required this.repository});

  PokemonDetail? _pokemonDetail;

  PokemonDetail? get pokemonDetail => _pokemonDetail;

  PokemonSpecies? _pokemonSpecies;

  PokemonSpecies? get pokemonSpecies => _pokemonSpecies;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future loadDetailAndSpecies(String name) {
    _isLoading = true;
    notifyListeners();

    return Future.wait(
      [
        repository
            .loadDetail(name)
            .then((loaded) => _pokemonDetail = loaded)
            .catchError((err) {}),
        repository
            .loadSpecies(name)
            .then((loaded) => _pokemonSpecies = loaded)
            .catchError((err) {}),
      ],
    ).then((_) {
      _isLoading = false;
      notifyListeners();
    }).catchError((_) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future loadDetail(String name) {
    _isLoading = true;
    notifyListeners();

    return repository.loadDetail(name).then((loaded) {
      _pokemonDetail = loaded;
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future loadSpecies(String name) async{
    _isLoading = true;
    notifyListeners();

    return await repository.loadSpecies(name).then((loaded) {
      _pokemonSpecies = loaded;
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }
}
