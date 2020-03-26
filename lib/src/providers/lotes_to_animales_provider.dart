import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/lotes_to_animales_bloc.dart';
import 'package:subastaspoli_mobile/src/models/lotes_to_animales_model.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class LotesToAnimalesProvider {
  bool _cargando = false;
  List<LotesToAnimalesModel> _lotesToAnimales = new List();

  Future<List<LotesToAnimalesModel>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final eventos = new LotesToAnimalesModelList.fromJsonList(decodedData);
    return eventos.items;
    
  }

  Future<List<LotesToAnimalesModel>> getLotesToAnimalByLote(
      BuildContext context, LotesToAnimalesBloc bloc,int numPage,int idLote) async {
    if (_cargando) return [];
    _cargando = true;


    if(numPage == 0){
      _lotesToAnimales.clear();
    }
    
    final url = Uri(
        scheme: Utils.scheme,
        host: Utils.host,
        port: Utils.port,
        path: '${Utils.path}/lotes-to-animales/id-lotes/${idLote.toString()}',
        queryParameters: {
          'page': numPage.toString(),
          'size': Utils.pageSize,
          'sort': 'id,desc',
        });

    final resp = await _procesarRespuesta(url);
    

    if(resp.isNotEmpty){
      _lotesToAnimales.addAll(resp);
      bloc.changeLotes(_lotesToAnimales);
    }
    _cargando = false;
    return resp;
  }
}
