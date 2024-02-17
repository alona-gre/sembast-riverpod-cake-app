import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riv_semb_cake_app/global_providers.dart';
// import 'package:riv_semb_cake_app/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riv_semb_cake_app/pages/jokes_screen.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appPath = await getApplicationDocumentsDirectory();
  appPath.createSync(recursive: true);
  final dbPath = join(appPath.path, 'cakes.db');
  final database = await databaseFactoryIo.openDatabase(dbPath);

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: const CakeApp(),
    ),
  );
}

class CakeApp extends StatelessWidget {
  const CakeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JokesScreen(),

      // HomePage(),
    );
  }
}
