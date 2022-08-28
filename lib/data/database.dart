import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constants/database_keys.dart';

class MyDatabase {
  MyDatabase._();

  // ignore: constant_identifier_names
  static const int DB_VERSION = 1;
  // ignore: constant_identifier_names
  static const String DB_NAME = 'mydatabase.db';
  static final MyDatabase db = MyDatabase._();
  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    String path = join(
      await getDatabasesPath(),
      DB_NAME,
    );

    final Future<Database> databaseObject =
        openDatabase(path, version: DB_VERSION, onCreate: (db, version) async {
      try {
        await createCartTable(db);
      } catch (_) {}
    });

    return databaseObject;
  }

  createCartTable(db) {
    String query = "CREATE TABLE $cartTableName ("
        "$keyId $primaryColumn "
        "$keyPrice $intColumn "
        "$keyQuantity $intColumn "
        "$keyTitle $varcharColumn "
        "$keyDescription $varcharColumn "
        "$keyImage $varcharColumn "
        "$keySlug $varcharColumnEnd "
        ")";
    db.execute(query);
  }
}
