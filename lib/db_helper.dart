import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "employees_database.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE EMPLOYEES (id INTEGER PRIMARY KEY, name TEXT, strikes INTEGER)");
  }

  Future<List<Map<String, dynamic>>> getData() async {
    var dbClient = await db;
    var result = await dbClient.query("employees_database");
    return result;
  }
}
