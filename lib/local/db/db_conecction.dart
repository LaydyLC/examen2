import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PartidaRepository {
  PartidaRepository();
  PartidaRepository._();
  static final PartidaRepository db = PartidaRepository._();
  Database _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path + "resultado.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE resultados(' +
          'id INTEGER PRIMARY KEY AUTOINCREMENT,' +
          'nombre_partida TEXT,' +
          'nombre_jugador1 TEXT,' +
          'nombre_jugador2 TEXT,' +
          'ganador TEXT,' +
          'punto INTEGER,' +
          'estado TEXT )');
    });
  }
}
