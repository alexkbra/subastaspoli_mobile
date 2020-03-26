

import 'package:subastaspoli_mobile/src/models/eventos_model.dart';
import 'package:rxdart/rxdart.dart';

class EventosBloc {

  final _eventosStreamController = BehaviorSubject<List<EventosModel>>();

  //Recuperar los datos del Stream
  Stream<List<EventosModel>> get eventosStream => _eventosStreamController.stream;

  // Insertar valores al Stream
  Function(List<EventosModel>) get changeEventos =>  _eventosStreamController.sink.add;

  List<EventosModel> get eventos => _eventosStreamController.value;

  dispose() {
    _eventosStreamController?.close();
  }


}