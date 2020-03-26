import 'package:subastaspoli_mobile/src/models/servicio_model.dart';

class RequerimientoRequest {


  String notas;
  List<Servicio> servicios;
  String idCliente;
  

  RequerimientoRequest({
    this.notas,
    this.servicios,
    this.idCliente
  });

  RequerimientoRequest.fromJsonMap(Map<String, dynamic> json){
    notas = json['notas'];
  }
  




}