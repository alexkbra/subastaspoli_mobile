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
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _listaItems(snapshot.data, context),
          ),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    
    final List<Widget> opciones = [];

    final bloc = Provider.ofLoginBloc(context);
    var per = 'OTHER';
    if (bloc?.email != null) {
      per = "USER";
    }
    final header = _buildHeader(context, bloc);
    opciones.add(header);

    data.forEach((opt) {
      opt['permit'].forEach((permit) {
        if (permit == per) {
          final widgetTemp = ListTile(
            title: Text(opt['texto']),
            leading: getIcon(opt['icon']),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blueGrey),
            onTap: () {
              if(opt['cerrar'] != null && opt['cerrar'] == true){
                _session.deleteAll();
                bloc.changeEmail(null);
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

  Widget _buildHeader(BuildContext context, LoginBloc bloc) {
    var email = 'Drawer Header';
    //final _screenSiza = MediaQuery.of(context).size;
    var imagen =
        'https://spikeybits.com/wp-content/uploads/2018/06/vulkan-wal.jpg';
    if (bloc?.email != null) {
      email = bloc.email.isEmpty ? email : bloc.email;
      imagen =
          'https://2.bp.blogspot.com/-irnh9D5GUX8/V1s5Gryn01I/AAAAAAAAKys/Mnk3yqcU82gXmiWFKs-AePtCNmDImxaFgCLcB/s1600/Magnus-The-Red-Primarchs-Warhammer-40000.jpeg';
    }

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
          Text(email)
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
      ),
    );
  }
}
