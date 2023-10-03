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
    CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    balance REAL NOT NULL
    )
    ''');

    batch.execute(
      '''
      CREATE TABLE transactions (
        sender INTEGER NOT NULL,
        reciever INTEGER NOT NULL,
        amount REAL NOT NULL
      )
'''
    );
    await batch.commit();
  }

  query() async {
    List response = await _db!.query('users');
    return response;
  }

  insert(Map<String, Object> map) async {
    int response = await _db!.insert('users', map);
    return response;
  }

  delete(int id) async {
    int response =
        await _db!.delete('users', where: 'id = ? ', whereArgs: [id]);
    return response;
  }

  deleteAll() async {
    int response = await _db!.delete('users');
    return response;
  }

  update(int id, Map<String, Object> map) async {
    int response = await _db!.update(
      'users',
      map,
      where: 'id = ?',
      whereArgs: [id],
    );
    return response;
  }

  deleteDataBasess()async{
        String dbpath = await getDatabasesPath();
    String path = join(dbpath, 'bank.db');

    await deleteDatabase(path);
    print('********************************************delete*******************');
  }
}