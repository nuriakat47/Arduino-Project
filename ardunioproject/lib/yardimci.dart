import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class KlimaVeritabaniYardimcisi {
  static final KlimaVeritabaniYardimcisi _yardimci = KlimaVeritabaniYardimcisi._internal();

  factory KlimaVeritabaniYardimcisi() {
    return _yardimci;
  }

  KlimaVeritabaniYardimcisi._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String veritabaniYolu = await getDatabasesPath();
    String path = join(veritabaniYolu, 'klima_veritabani.db');

    return await openDatabase(path, version: 1, onCreate: _olusturTablo);
  }

  Future<void> _olusturTablo(Database db, int version) async {
    await db.execute('''
      CREATE TABLE klima (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bilgi TEXT
      )
    ''');
  }

  Future<void> klimaEkle(String bilgi) async {
    final db = await database;
    await db.insert(
      'klima',
      {'bilgi': bilgi},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> tumKlimaBilgileriGetir() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('klima');

    return List.generate(maps.length, (i) {
      return maps[i]['bilgi'];
    });
  }

  Future<void> tumKlimalariSil() async {
    final db = await database;
    await db.delete('klima');
  }
}
