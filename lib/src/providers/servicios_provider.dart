import 'dart:async';
import 'dart:convert';

import 'package:subastaspoli_mobile/src/bloc/servicio_bloc.dart';
import 'package:subastaspoli_mobile/src/models/mensaje_respuesta.dart';
import 'package:subastaspoli_mobile/src/models/requerimiento_model.dart';
import 'package:subastaspoli_mobile/src/models/servicio_model.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class ServiciosProvider {
  int _servicioPage = -1;
  bool _cargando = false;

  List<Servicio> _servicios = new List();

  Future<List<Servicio>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final servicios = new Servicios.fromJsonList(decodeData['content']);
    return servicios.items;
  }

  Future<MensajeRespuesta> _procesarRespuestaCrearRequerimiento(Uri url) async {
    final resp = await http.post(url);
    final decodeData = json.decode(resp.body);
    final mensaje = new MensajeRespuesta.fromJsonMap(decodeData['content']);
    return mensaje;
  }

  Future<MensajeRespuesta> crearRequerimiento({RequerimientoRequest request}) async {
    if (_cargando) return null;
    _cargando = true;

    final url = Uri(
        scheme: Utils.scheme,
        host: Utils.host,
        port: Utils.port,
        path: '${Utils.path}/requerimiento',
        queryParameters: {
          'notas':request.notas,
          'idCliente': request.idCliente,
          'servicios': json.encode(request.servicios),
        });
    final resp = await _procesarRespuestaCrearRequerimiento(url);
    _cargando = false;
    return resp;
  }

  Future<List<Servicio>> getServicios(
      {int servicioPage = 0, ServiciosBloc bloc}) async {
    if (_cargando) return [];
    _cargando = true;

    _servicioPage = servicioPage;

    final url = Uri(
        scheme: Utils.scheme,
        host: Utils.host,
        port: Utils.port,
        path: '${Utils.path}/servicio',
        queryParameters: {
          'page': _servicioPage.toString(),
          'size': Utils.pageSize,
          'sort': 'nombre',
        });

    final resp = await _procesarRespuesta(url);
    _servicios.clear();
    _servicios.addAll(resp);
    bloc.changeServicios(_servicios);

    _cargando = false;
    return resp;
  }
}
