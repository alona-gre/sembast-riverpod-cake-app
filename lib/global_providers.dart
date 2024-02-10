import 'package:riverpod/riverpod.dart';
import 'package:sembast/sembast.dart';

final databaseProvider =
    Provider<Database>((_) => throw Exception('Database not initialized'));
