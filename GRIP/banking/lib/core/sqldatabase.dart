import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB {
  static Database? _db;

  Future<Database> get db async {
    if (_db == null)
      return _db = await initDatabase();
    else
      return _db!;
  }

  initDatabase() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, 'bank.db');

    Database myDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    balance REAL NOT NULL
    )
    ''');

    batch.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sender TEXT NOT NULL,
        receiver TEXT NOT NULL,
        amount REAL NOT NULL
      )
''');
    await batch.commit();
  }

  query(String tableName) async {
    List response = await _db!.query(tableName);
    return response;
  }

  insert(Map<String, Object> map, String tableName) async {
    int response = await _db!.insert(tableName, map);
    return response;
  }

  update(int id, Map<String, Object> map) async {
    int response = await _db!.update(
      'customers',
      map,
      where: 'id = ?',
      whereArgs: [id],
    );
    return response;
  }
}
