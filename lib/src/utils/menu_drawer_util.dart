import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/providers/menu_provider.dart';
import 'package:subastaspoli_mobile/src/utils/icono_string_util.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';

class MenuDrawerUtil extends StatefulWidget {
  MenuDrawerUtil({Key key}) : super(key: key);

  _MenuDrawerUtilState createState() => _MenuDrawerUtilState();
}

class _MenuDrawerUtilState extends State<MenuDrawerUtil> {
  final Session _session = new Session();

  @override
  Widget build(BuildContext context) {
    return _lista();
  }

  Widget _lista() {
    print(menuProvier.opciones);
    return FutureBuilder(
      future: menuProvier.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return FutureBuilder(
            future: _listaItems(snapshot.data, context),
            builder:
                (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: snapshot.data,
                ),
              );
            });

        /* */
      },
    );
  }

  Future<List<Widget>> _listaItems(
      List<dynamic> data, BuildContext context) async {
    final List<Widget> opciones = [];
    var per = 'OTHER';
    final dataSession = await _session.get();
    if (dataSession != null &&
        dataSession['idToken'] != null &&
        dataSession['idToken'].toString().isNotEmpty) {
      per = "USER";
    }

    final bloc = Provider.ofLoginBloc(context);
    final header = await _buildHeader(context, bloc);
    opciones.add(header);

    data.forEach((opt) {
      opt['permit'].forEach((permit) {
        if (permit == per) {
          final widgetTemp = ListTile(
            title: Text(opt['texto']),
            leading: getIcon(opt['icon']),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blueGrey),
            onTap: () {
              if (opt['cerrar'] != null && opt['cerrar'] == true) {
                _session.deleteAll();
              }
              Navigator.pushNamed(context, opt['ruta']);
              _session.putEntidad(key: "whereIAmNow", id: 0);
            },
          );
          opciones..add(widgetTemp);
        }
      });
    });

    return opciones;
  }

  Future<Widget> _buildHeader(BuildContext context, LoginBloc bloc) async {
    var imagen =
        'https://i.pinimg.com/564x/69/fc/f6/69fcf604bc6e652c94954c23040dbad3.jpg';

    return DrawerHeader(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imagen),
              radius: 60.0,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),
    );
  }
}
