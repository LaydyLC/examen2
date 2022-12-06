import 'dart:async';
import 'package:tres_en_raya/models/PartidaModelo.dart';
import 'package:tres_en_raya/repository/ResultadoRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'partida_event.dart';
part 'partida_state.dart';

class PartidaBloc extends Bloc<PartidaEvent, PartidaState> {
  final PartidaRepository _partidaRepository;
  PartidaBloc({PartidaRepository partidaRepository})
      : _partidaRepository = partidaRepository,
        super(PartidaInitialState());
  @override
  Stream<PartidaState> mapEventToState(PartidaEvent event) async* {
    if (event is ListarPartidaEvent) {
      yield PartidaLoadingState();
      try {
        List<PartidaModelo> partidaList = await _partidaRepository.getPartida();
        yield PartidaLoadedState(partidaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PartidaError(e);
      }
    } else if (event is DeletePartidaEvent) {
      try {
        await _partidaRepository.deletePartida(event.partida.id);
        yield PartidaLoadingState();
        List<PartidaModelo> resultadoList =
            await _partidaRepository.getPartida();
        yield PartidaLoadedState(resultadoList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PartidaError(e);
      }
    } else if (event is CreatePartidaEvent) {
      try {
        await _partidaRepository.createPartida(event.partida);
        yield PartidaLoadingState();
        List<PartidaModelo> partidaList = await _partidaRepository.getPartida();
        yield PartidaLoadedState(partidaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PartidaError(e);
      }
    } else if (event is UpdatePartidaEvent) {
      try {
        await _partidaRepository.updatePartida(event.partida.id, event.partida);
        yield PartidaLoadingState();
        List<PartidaModelo> resultadoList =
            await _partidaRepository.getPartida();
        yield PartidaLoadedState(resultadoList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PartidaError(e);
      }
    }
  }
}
