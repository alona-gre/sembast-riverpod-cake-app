import 'package:riv_semb_cake_app/models/cake.dart';

abstract class CakeRepository {
  Future<int> insertCake(Cake cake);

  Future updateCake(Cake cake);

  Future deleteCake(int cakeId);

  Stream<List<Cake>> getAllCakesStream();
}
