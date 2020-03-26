import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/lotes_bloc.dart';
import 'package:subastaspoli_mobile/src/models/lotes_model.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class LotesProvider {
  bool _cargando = false;
  List<LotesModel> _lotes = new List();

  Future<List<LotesModel>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final eventos = new LotesModelList.fromJsonList(decodedData);
    return eventos.items;
    
  }

  Future<List<LotesModel>> getLotesBySubastas(
      BuildContext context, LotesBloc bloc,int eventosPage,int idSubastas) async {
    if (_cargando) return [];
    _cargando = true;


    if(eventosPage == 0){
      _lotes.clear();
    }
    
    final url = Uri(
        scheme: Utils.scheme,
        host: Utils.host,
        port: Utils.port,
        path: '${Utils.path}/lotes/id-subasta/${idSubastas.toString()}',
        queryParameters: {
          'page': eventosPage.toString(),
          'size': Utils.pageSize,
          'sort': 'id,desc',
        });

    final resp = await _procesarRespuesta(url);
    

    if(resp.isNotEmpty){
      _lotes.addAll(resp);
      bloc.changeLotes(_lotes);
    }
    _cargando = false;
    return resp;
  }
}
