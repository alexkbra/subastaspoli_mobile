import 'package:flutter/cupertino.dart';
import 'package:subastaspoli_mobile/src/pages/detalle_animales_page.dart';
import 'package:subastaspoli_mobile/src/pages/detalle_evento_page.dart';
import 'package:subastaspoli_mobile/src/pages/detalle_lotes_page.dart';
import 'package:subastaspoli_mobile/src/pages/detalle_subasta_page.dart';
import 'package:subastaspoli_mobile/src/pages/home_page.dart';
import 'package:subastaspoli_mobile/src/pages/login_page.dart';
import 'package:subastaspoli_mobile/src/pages/login_v2_page.dart';
import 'package:subastaspoli_mobile/src/pages/puja_page.dart';
import 'package:subastaspoli_mobile/src/pages/requerimiento_page.dart';
import 'package:subastaspoli_mobile/src/pages/servicios_page.dart';
import 'package:subastaspoli_mobile/src/pages/sing_up_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){

  return <String, WidgetBuilder>{
      HomePage.pageName : (BuildContext context ) => HomePage(),
      ServiciosPage.pageName : (BuildContext context ) => ServiciosPage(),
      RequerimientoPage.pageName : (BuildContext context ) =>  RequerimientoPage(),
      LoginPage.pageName : (BuildContext context ) =>  LoginPage(),
      LoginV2Page.pageName : (BuildContext context ) => LoginV2Page(),
      DetalleEventoPage.pageName : ( BuildContext context ) => DetalleEventoPage(),
      DetalleSubastaPage.pageName : ( BuildContext context ) => DetalleSubastaPage(),
      DetalleLotesPage.pageName : ( BuildContext context ) => DetalleLotesPage(),
      DetalleAnimalesPage.pageName : ( BuildContext context ) => DetalleAnimalesPage(),
      PujaPage.pageName : ( BuildContext context ) => PujaPage(),
      SingUpPage.pageName : (BuildContext context) => SingUpPage(),
  };


}