

import 'package:rxdart/rxdart.dart';
import 'package:subastaspoli_mobile/src/models/subastas_model.dart';

class SubastasBloc {

  final _subastasStreamController = BehaviorSubject<List<SubastasModel>>();

  //Recuperar los datos del Stream
  Stream<List<SubastasModel>> get subastasStream => _subastasStreamController.stream;

  // Insertar valores al Stream
  Function(List<SubastasModel>) get changeSubastas =>  _subastasStreamController.sink.add;

  List<SubastasModel> get subastas => _subastasStreamController.value;

  dispose() {
    _subastasStreamController?.close();
  }


}