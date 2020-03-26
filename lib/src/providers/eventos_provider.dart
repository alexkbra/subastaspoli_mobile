import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/eventos_bloc.dart';
import 'package:subastaspoli_mobile/src/models/eventos_model.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class EventosProvider {
  bool _cargando = false;
  List<EventosModel> _eventos = new List();

  Future<List<EventosModel>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final eventos = new EventosModelList.fromJsonList(decodedData);
    return eventos.items;
  }

  Future<List<EventosModel>> getEventos(
      BuildContext context, EventosBloc bloc,int eventosPage) async {
    if (_cargando) return [];
    _cargando = true;


    if(eventosPage == 0){
      _eventos.clear();
    }
    
    final url = Uri(
        scheme: Utils.scheme,
        host: Utils.host,
        port: Utils.port,
        path: '${Utils.path}/eventos/now',
        queryParameters: {
          'page': eventosPage.toString(),
          'size': Utils.pageSize,
          'sort': 'id,desc',
        });

    final resp = await _procesarRespuesta(url);

    if(resp.isNotEmpty){
      _eventos.addAll(resp);
      bloc.changeEventos(_eventos);
    }
    _cargando = false;
    return resp;
  }
}
