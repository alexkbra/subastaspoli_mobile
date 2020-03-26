import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/contenidos_bloc.dart';
import 'package:subastaspoli_mobile/src/bloc/login_bloc.dart';
import 'package:subastaspoli_mobile/src/bloc/eventos_bloc.dart';
import 'package:subastaspoli_mobile/src/bloc/lotes_bloc.dart';
import 'package:subastaspoli_mobile/src/bloc/lotes_to_animales_bloc.dart';
import 'package:subastaspoli_mobile/src/bloc/servicio_bloc.dart';
import 'package:subastaspoli_mobile/src/bloc/subastas_bloc.dart';
export 'package:subastaspoli_mobile/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  final loginBloc = new LoginBloc();
  final eventosBloc = new EventosBloc();
  final serviciosBloc = new ServiciosBloc();
  final subastasBloc = new SubastasBloc();
  final lotesBloc = new LotesBloc();
  final lotesToAnimalesBloc = new LotesToAnimalesBloc(); 
  final contenidosBolc = new ContenidosBloc();

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc ofLoginBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        .loginBloc;
  }

  static EventosBloc ofEventosBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        .eventosBloc;
  }

  static ServiciosBloc ofServicioBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        .serviciosBloc;
  }

  static SubastasBloc ofSubastasBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        .subastasBloc;
  }

  static LotesBloc ofLotesBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        .lotesBloc;
  }

  static LotesToAnimalesBloc ofLotesToAnimalesBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        .lotesToAnimalesBloc;
  }

  static ContenidosBloc ofContenidoBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>())
        .contenidosBolc;
  }

}
