

import 'package:rxdart/rxdart.dart';
import 'package:subastaspoli_mobile/src/models/contenidos_model.dart';

class ContenidosBloc {

  final _contenidoStreamController = BehaviorSubject<List<ContenidosModel>>();

  //Recuperar los datos del Stream
  Stream<List<ContenidosModel>> get contenidoStream => _contenidoStreamController.stream;

  // Insertar valores al Stream
  Function(List<ContenidosModel>) get changeContenido =>  _contenidoStreamController.sink.add;

  List<ContenidosModel> get lotes => _contenidoStreamController.value;

  dispose() {
    _contenidoStreamController?.close();
  }


}