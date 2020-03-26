import 'package:flutter/material.dart';

final _icons = <String, IconData>{

  'novedad'   : Icons.fiber_new,
  'service_client' : Icons.build,
  'business' : Icons.send,
  'school': Icons.school,
  'login': Icons.supervised_user_circle,
  'puja': Icons.add_shopping_cart,
  'valor': Icons.business_center,
  'cerrar_session': Icons.supervisor_account
};


Icon getIcon ( String nombreIcono ) {

  return Icon( _icons[nombreIcono], color: Colors.blueGrey );

}