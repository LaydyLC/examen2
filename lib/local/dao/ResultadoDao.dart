import 'package:tres_en_raya/local/db/db_conecction.dart';
import 'package:tres_en_raya/models/PartidaModelo.dart';

class PartidaLocate extends PartidaRepository {
  Future<List<PartidaModelo>> getAllPartida() async {
    final db = await database;
    var result = await db.rawQuery('SELECT * FROM resultados');
    List<PartidaModelo> listProduct = result.isNotEmpty
        ? result.map((c) => PartidaModelo.fromObject(c)).toList()
        : [];
    return listProduct;
  }

  Future<MsgModelo> createPartida(PartidaModelo partida) async {
    final db = await database;
    var result = await db.rawInsert(
        'INSERT INTO resultados(nombre_partida, nombre_jugador1, nombre_jugador2, ganador, punto, estado) VALUES(?,?,?,?,?,?)',
        [
          partida.nombre_partida,
          partida.nombre_jugador1,
          partida.nombre_jugador2,
          partida.ganador,
          partida.punto,
          partida.estado
        ]);
    Map<String, dynamic> resultado = {'mensaje': "Se creo correctamente"};
    if (result == 1) {
      return Future.value(MsgModelo.fromJson(resultado));
    }
    resultado["mensaje"] = "No se pudo Registrar";
    return Future.value(MsgModelo.fromJson(resultado));
  }

  //Actualizar Datos
  Future<MsgModelo> updatePartida(PartidaModelo partida) async {
    final db = await database;
    int result = await db.update('resultados', partida.toMap(),
        where: 'id = ${partida.id}');
    Map<String, dynamic> resultado = {'mensaje': "updated!!"};
    if (result == 1) {
      return Future.value(MsgModelo.fromJson(resultado));
    }
    resultado["mensaje"] = "No se pudo modificar los datos";
    return Future.value(MsgModelo.fromJson(resultado));
  }

  //Eliminar
  Future<MsgModelo> deletePartida(int id) async {
    final db = await database;
    var res = await db.delete('resultados', where: 'id = $id');
    Map<String, dynamic> resultado = {'mensaje': "Deleted!!", 'id': id};
    if (res == 1) {
      return Future.value(MsgModelo.fromJson(resultado));
    }
    resultado["mensaje"] = "Error al eliminar";
    return Future.value(MsgModelo.fromJson(resultado));
  }

  Future<int> deleteAll() async {
    final db = await database;
    return await db.delete('resultados');
  }
}
