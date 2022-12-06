part of 'partida_bloc.dart';

abstract class PartidaEvent {
  final PartidaModelo partida;
  const PartidaEvent({this.partida});
}

class ListarPartidaEvent extends PartidaEvent {
  ListarPartidaEvent();
}

class DeletePartidaEvent extends PartidaEvent {
  DeletePartidaEvent({@required PartidaModelo partida})
      : super(partida: partida);
}

class UpdatePartidaEvent extends PartidaEvent {
  UpdatePartidaEvent({@required PartidaModelo partida})
      : super(partida: partida);
}

class CreatePartidaEvent extends PartidaEvent {
  CreatePartidaEvent({@required PartidaModelo partida})
      : super(partida: partida);
}
