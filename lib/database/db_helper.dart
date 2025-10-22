import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/band.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'bands.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE bands (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            genre TEXT,
            imagePath TEXT,
            city TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertBand(Band band) async {
    final dbClient = await db;
    return await dbClient.insert('bands', band.toMap());
  }

  Future<List<Band>> getBands() async {
    final dbClient = await db;
    final result = await dbClient.query('bands');
    return result.map((data) => Band.fromMap(data)).toList();
  }

  Future<int> deleteBand(int id) async {
    final dbClient = await db;
    return await dbClient.delete('bands', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBand(Band band) async {
    final dbClient = await db;
    return await dbClient.update(
      'bands',
      band.toMap(),
      where: 'id = ?',
      whereArgs: [band.id],
    );
  }
}
