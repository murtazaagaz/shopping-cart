import 'package:manektech/data/constants/database_keys.dart';
import 'package:manektech/data/database.dart';
import 'package:manektech/data/models/product.dart';
import 'package:sqflite/sqflite.dart';

class DbRepository {
  static final DbRepository _singleton = DbRepository._internal();

  factory DbRepository() {
    return _singleton;
  }
  DbRepository._internal();

  Database? database;

  Future<void> addProducts(Product product) async {
    database ??= await MyDatabase.db.database;

    try {
      await database!.insert(cartTableName, product.toMap());
    } catch (_) {}
  }

  Future<List<Product>> getCart() async {
    List<Product> products = [];
    database ??= await MyDatabase.db.database;

    try {
      final List<Map<String, dynamic>> p = await database!.query(cartTableName);
      products = p.map((e) {
        return Product.fromMap(e);
      }).toList();
    } catch (_) {}
    return products;
  }

  Future<void> deleteItemFromCart(int id) async {
    database ??= await MyDatabase.db.database;
    try {
      await database!
          .delete(cartTableName, where: keyId + ' =?', whereArgs: [id]);
    } catch (_) {}
  }
}
