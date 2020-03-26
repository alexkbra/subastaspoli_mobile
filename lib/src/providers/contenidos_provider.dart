import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/contenidos_bloc.dart';
import 'package:subastaspoli_mobile/src/models/contenidos_model.dart';
import 'package:subastaspoli_mobile/src/models/eventos_model.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class ContenidosProvider {
  bool _cargando = false;
  List<ContenidosModel> _contenidos = new List();

  Future<List<ContenidosModel>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final eventos = new ContenidosModelList.fromJsonList(decodedData);
    return eventos.items;
  }

  Future<List<ContenidosModel>> getContenidos(
      BuildContext context, ContenidosBloc bloc,int numPage,int idEtnidad,String entidad) async {
    if (_cargando) return [];
    _cargando = true;


    if(numPage == 0){
      _contenidos.clear();
    }
    
    final url = Uri(
        scheme: Utils.scheme,
        host: Utils.host,
        port: Utils.port,
        path: '${Utils.path}/contenidos/entidad/${idEtnidad.toString()}/$entidad',
        queryParameters: {
          'page': numPage.toString(),
          'size': Utils.pageSize,
          'sort': 'id,desc',
        });

    final resp = await _procesarRespuesta(url);

    if(resp.isNotEmpty){
      _contenidos.addAll(resp);
      bloc.changeContenido(_contenidos);
    }
    _cargando = false;
    return resp;
  }
}
