import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riv_semb_cake_app/global_providers.dart';
import 'package:riv_semb_cake_app/models/cake.dart';
import 'package:riv_semb_cake_app/repositories/cake_repository.dart';
import 'package:sembast/sembast.dart';

final cakeRepositoryProvider = Provider(
  (ref) => SembastCakeRepository(
    database: ref.watch(databaseProvider),
  ),
);

class SembastCakeRepository implements CakeRepository {
  final Database database;
  late final StoreRef<int, Map<String, dynamic>> _store;

  SembastCakeRepository({required this.database}) {
    _store = intMapStoreFactory.store('cake_store');
  }

  @override
  Future<int> insertCake(Cake cake) => _store.add(database, cake.toJson());

  @override
  Future<void> updateCake(Cake cake) =>
      _store.record(cake.id!).update(database, cake.toJson());

  @override
  Future deleteCake(int cakeId) => _store.record(cakeId).delete(database);

  @override
  Stream<List<Cake>> getAllCakesStream() =>
      _store.query().onSnapshots(database).map(
            (snapshot) => snapshot
                .map((cake) => Cake.fromJson(cake.value).copyWith(id: cake.key))
                .toList(growable: false),
          );
}
