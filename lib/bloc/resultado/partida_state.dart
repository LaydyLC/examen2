part of 'partida_bloc.dart';

class PartidaState {}

class PartidaInitialState extends PartidaState {}

class PartidaLoadingState extends PartidaState {}

class PartidaLoadedState extends PartidaState {
  List<PartidaModelo> partidaList;
  PartidaLoadedState(this.partidaList);
}

class PartidaError extends PartidaState {
  Error e;
  PartidaError(this.e);
}
