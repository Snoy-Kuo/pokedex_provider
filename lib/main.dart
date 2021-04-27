// @dart=2.9
import 'package:flutter/material.dart';

import 'app.dart';
import 'common/repository/remote_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App(
    repository: RemoteRepository(),
  ));
}
