import 'dart:async';
import 'package:tres_en_raya/local/dao/ResultadoDao.dart';
import 'package:tres_en_raya/models/PartidaModelo.dart';
import 'package:dio/dio.dart';

class PartidaRepository {
  PartidaLocate partidaLocal;
  bool result;

  PartidaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    partidaLocal = PartidaLocate();
  }

  Future<List<PartidaModelo>> getPartida() async {
    return await partidaLocal.getAllPartida();
  }

  Future<MsgModelo> deletePartida(int id) async {
    return await partidaLocal.deletePartida(id);
  }

  Future<MsgModelo> updatePartida(int id, PartidaModelo resultadom) async {
    return await partidaLocal.updatePartida(resultadom);
  }

  Future<MsgModelo> createPartida(PartidaModelo resultado) async {
    return await partidaLocal.createPartida(resultado);
  }
}
