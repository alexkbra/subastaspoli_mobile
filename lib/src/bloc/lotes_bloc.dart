

import 'package:rxdart/rxdart.dart';
import 'package:subastaspoli_mobile/src/models/lotes_model.dart';

class LotesBloc {

  final _lotesStreamController = BehaviorSubject<List<LotesModel>>();

  //Recuperar los datos del Stream
  Stream<List<LotesModel>> get lotesStream => _lotesStreamController.stream;

  // Insertar valores al Stream
  Function(List<LotesModel>) get changeLotes =>  _lotesStreamController.sink.add;

  List<LotesModel> get lotes => _lotesStreamController.value;

  dispose() {
    _lotesStreamController?.close();
  }


}