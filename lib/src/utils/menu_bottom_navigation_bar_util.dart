import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/models/lotes_model.dart';
import 'package:subastaspoli_mobile/src/pages/home_page.dart';
import 'package:subastaspoli_mobile/src/pages/login_v2_page.dart';
import 'package:subastaspoli_mobile/src/pages/puja_page.dart';
import 'package:subastaspoli_mobile/src/providers/menu_provider.dart';
import 'package:subastaspoli_mobile/src/utils/dialogs.dart';
import 'package:subastaspoli_mobile/src/utils/icono_string_util.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';

class MenuBottomNavigationBarUtil extends StatefulWidget {

  final LotesModel lote;

  MenuBottomNavigationBarUtil({this.lote});

  _MenuBottomNavigationBarUtilState createState() =>
      _MenuBottomNavigationBarUtilState();
}

class _MenuBottomNavigationBarUtilState
    extends State<MenuBottomNavigationBarUtil> {
  List<dynamic> data = [];
  final Session _session = new Session();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _lista();
  }

  Widget _lista() {
    print(menuProvier.opciones);
    return FutureBuilder(
      future: menuProvier.cargarNavegacion(),
      initialData: [
        {'texto': '', 'icon': ''},
        {'texto': '', 'icon': ''}
      ],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        data = snapshot.data;
        return BottomNavigationBar(
          items: _listaItems(snapshot.data, context),
          elevation: 0.8,
          selectedItemColor: Colors.blueGrey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        );
      },
    );
  }

  void _onItemTapped(int index) async {
    if (data[index]['pujar'] != null && data[index]['pujar'] == true) {
      final dataSession = await _session.get();
      if (dataSession != null &&
          dataSession['idToken'] != null &&
          dataSession['idToken'].toString().isNotEmpty) {
        final isEvento = await _session.getEntidad(key: "eventoid");
        final isSubasta = await _session.getEntidad(key: "subastaid");
        final isLote = await _session.getEntidad(key: "loteid");
        if (isEvento != null && isSubasta != null && isLote != null) {
          Navigator.pushNamed(context, PujaPage.pageName);
        } else {
          Navigator.pushNamed(context, HomePage.pageName);
        }
      } else {
        Dialogs.alertInfo(context,
            message: "regístrate o inicia sesión..",
            redirectPageName: LoginV2Page.pageName, lote: widget.lote);
             _session.putEntidad(key: "whereIAmNow", id: 1);
      }
    } else {
      Navigator.pushNamed(context, data[index]['ruta']);
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _listaItems(
      List<dynamic> data, BuildContext context) {
    final List<BottomNavigationBarItem> opciones = [];
    data.forEach((opt) {
      final widgetTemp = BottomNavigationBarItem(
        title: Text(opt['texto']),
        icon: getIcon(opt['icon']),
      );
      opciones.add(widgetTemp);
    });

    return opciones;
  }
}
