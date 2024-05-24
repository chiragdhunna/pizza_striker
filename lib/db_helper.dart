import 'package:logger/web.dart';
import 'package:pizza_striker/logic/models/admin_model.dart';
import 'package:pizza_striker/logic/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

const List<String> userValues = ['id', 'name', 'strikes', 'created_time'];

const List<String> adminValues = [
  'id',
  'name',
  'createdAt',
  'updatedAt',
];

Logger log = Logger(printer: PrettyPrinter());

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/pizzaStriker.db';
    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future _create(Database db, int version) async {
    try {
      await db.execute('''
    CREATE TABLE USER(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      strikes INTEGER,
      username TEXT,
      password TEXT,
      email TEXT
    )
''');
    } catch (e) {
      log.e('Error in query : $e');
    }

    try {
      await db.execute('''
    CREATE TABLE ADMIN(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      createdAt TEXT,
      updatedAt TEXT
    )
''');
    } catch (e) {
      log.e('Error in query $e');
    }
  }

  Future<User> createUser(User user) async {
    final db = await _instance.database;
    final id = await db.insert('USER', user.toJson());
    return user.copyWith(
      id: id,
      name: user.name,
      strikes: user.strikes,
      email: user.email,
      password: user.password,
      username: user.username,
    );
  }

  Future<Admin> createAdmin(Admin admin) async {
    final db = await _instance.database;
    final id = await db.insert('ADMIN', admin.toJson());
    return admin.copyWith(
      id: id,
      name: admin.name,
      phoneNumber: admin.phoneNumber,
      createdAt: admin.createdAt,
      updatedAt: admin.updatedAt,
    );
  }

  Future<User> readUserDB(int id) async {
    final db = await _instance.database;
    final maps = await db.query(
      'USER',
      columns: userValues,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      log.e('ID not available from readUserDB : $id');
      throw Exception('ID $id not found');
    }
  }

  Future<Admin> readAdminDB(int id) async {
    final db = await _instance.database;
    final maps = await db.query(
      'ADMIN',
      columns: adminValues,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Admin.fromJson(maps.first);
    } else {
      log.e('ID not available from readUserDB : $id');
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllUser() async {
    final db = await _instance.database;
    const orderBy = 'id ASC';
    final result = await db.query('USER', orderBy: orderBy);
    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<List<Admin>> readAllAdmin() async {
    final db = await _instance.database;
    const orderBy = 'created_time DESC';
    final result = await db.query('Admin', orderBy: orderBy);
    return result.map((json) => Admin.fromJson(json)).toList();
  }

  Future<int> updateUser(User user) async {
    final db = await _instance.database;
    return db.update(
      'USER',
      user.toJson(),
      where: 'id = ?',
      whereArgs: ['id'],
    );
  }

  Future<int> updateAdmin(Admin admin) async {
    final db = await _instance.database;
    return db.update(
      'ADMIN',
      admin.toJson(),
      where: 'id = ?',
      whereArgs: ['id'],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await _instance.database;
    return await db.delete(
      'USER',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAdmin(int id) async {
    final db = await _instance.database;
    return await db.delete(
      'ADMIN',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await _instance.database;
    db.close();
  }
}
