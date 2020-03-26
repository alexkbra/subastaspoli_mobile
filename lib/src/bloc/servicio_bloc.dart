

import 'package:subastaspoli_mobile/src/models/mensaje_respuesta.dart' as prefix0;
import 'package:subastaspoli_mobile/src/models/servicio_model.dart';
import 'package:rxdart/rxdart.dart';

class ServiciosBloc {

  final _serviciosStramController = new BehaviorSubject<List<Servicio>>();
  final _requerimientoStramController = new BehaviorSubject<prefix0.MensajeRespuesta>();

  //Recuperar los datos del Stream
  
  Stream<List<Servicio>> get serviciosStram => _serviciosStramController.stream;
  Stream<prefix0.MensajeRespuesta> get requerimientoStram => _requerimientoStramController.stream;
  
  //
  Function(List<Servicio>) get changeServicios => _serviciosStramController.sink.add;
  Function(prefix0.MensajeRespuesta) get changeRequerimiento => _requerimientoStramController.sink.add;

  //Obtener el ultimo valor ingresado a los streams
  List<Servicio> get servicios => _serviciosStramController.value;
  prefix0.MensajeRespuesta get mensajeRespuesta => _requerimientoStramController.value;

  dispose() {
    _serviciosStramController?.close();
    _requerimientoStramController?.close();
  }

}