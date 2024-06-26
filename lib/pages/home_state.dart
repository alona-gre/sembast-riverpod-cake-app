import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riv_semb_cake_app/repositories/sembast_cake_repository.dart';

final cakesProvider = StreamProvider(
  (ref) => ref.watch(cakeRepositoryProvider).getAllCakesStream(),
);
