import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/subastas_bloc.dart';
import 'package:subastaspoli_mobile/src/models/subastas_model.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class SubastasProvider {
  bool _cargando = false;
  List<SubastasModel> _subastas = new List();

  Future<List<SubastasModel>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final eventos = new SubastasModelList.fromJsonList(decodedData);
    return eventos.items;
    
  }

  Future<List<SubastasModel>> getSubastasByEventos(
      BuildContext context, SubastasBloc bloc,int eventosPage,int idEvento) async {
    if (_cargando) return [];
    _cargando = true;


    if(eventosPage == 0){
      _subastas.clear();
    }
    
    final url = Uri(
        scheme: Utils.scheme,
        host: Utils.host,
        port: Utils.port,
        path: '${Utils.path}/subastas/id-evento/${idEvento.toString()}',
        queryParameters: {
          'page': eventosPage.toString(),
          'size': Utils.pageSize,
          'sort': 'id,desc',
        });

    final resp = await _procesarRespuesta(url);

    if(resp.isNotEmpty){
      _subastas.addAll(resp);
      bloc.changeSubastas(_subastas);
    }
    _cargando = false;
    return resp;
  }
}
