

import 'package:rxdart/rxdart.dart';
import 'package:subastaspoli_mobile/src/models/lotes_to_animales_model.dart';

class LotesToAnimalesBloc {

  final _lotesToAnimalesStreamController = BehaviorSubject<List<LotesToAnimalesModel>>();

  //Recuperar los datos del Stream
  Stream<List<LotesToAnimalesModel>> get lotesStream => _lotesToAnimalesStreamController.stream;

  // Insertar valores al Stream
  Function(List<LotesToAnimalesModel>) get changeLotes =>  _lotesToAnimalesStreamController.sink.add;

  List<LotesToAnimalesModel> get lotes => _lotesToAnimalesStreamController.value;

  dispose() {
    _lotesToAnimalesStreamController?.close();
  }


}