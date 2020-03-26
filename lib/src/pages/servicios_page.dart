import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/models/mensaje_respuesta.dart';
import 'package:subastaspoli_mobile/src/models/requerimiento_model.dart';
//import 'package:subastaspoli_mobile/src/bloc/servicio_bloc.dart';
import 'package:subastaspoli_mobile/src/models/servicio_model.dart';
import 'package:subastaspoli_mobile/src/providers/servicios_provider.dart';

class ServiciosPage extends StatefulWidget {
  static final pageName = "service_client";
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  final ServiciosProvider servicosProvider = new ServiciosProvider();
  ScrollController _scrollController = new ScrollController();
  final TextEditingController _controllerTextEditing =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Servicio> servicios = new List();
  int _servicioPage = 0;
  bool _isLoading = false;
  String _problema = '';

  @override
  void initState() {
    super.initState();
    servicios.clear();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  Future<Null> _fetchData() async {
    _isLoading = true;
    servicios.clear();
    setState(() {
      servicosProvider.getServicios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('¿Requiere soporte en?'),
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: _buildListMain(context));
  }

  Widget _buildListMain(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.8,
        child: Column(
          children: <Widget>[
            _buildList(servicios, context, size),
            _buildForm(),
            _crearLoading(),
          ],
        ),
      ),
    );

    /*StreamBuilder(
      stream: bloc.serviciosStram,
      builder: (BuildContext context, AsyncSnapshot<List<Servicio>> snapshot) {
        if (snapshot.hasData) {
          servicios.clear();
          Set<Servicio> set = Set.from(snapshot.data);
          set.forEach((element) => element.check = false);    
          servicios.addAll(snapshot.data);
         
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );*/
  }

  Widget _buildList(List<Servicio> servicios, BuildContext context, Size size) {
    //servicosProvider.getServicios(bloc: bloc);

    return RefreshIndicator(
        onRefresh: _obtenerPagina,
        child:
            Container(height: size.height * 0.3, child: _buildListServicios()));

    /*return RefreshIndicator(
        onRefresh: _obtenerPagina,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: servicios.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              title: Text(servicios[index].nombre),
              value: servicios[index].check,
              onChanged: (valor){
                setState(() {
                    servicios[index].check = valor; 
                });
              },
            );
            /*return FlatButton(
              child: Text(servicios[index].nombre),
              onPressed: () {
                Navigator.pushNamed(context, 'requerimiento',
                    arguments: servicios[index]);
              },
            );*/
          },
        ));*/
  }

  Widget _buildListServicios() {
    //inal bloc = Provider.ofServicioBolc(context);
    if (servicios.isEmpty) {
      final bloc = Provider.ofServicioBloc(context);
      servicosProvider.getServicios(bloc: bloc);
      return StreamBuilder(
        stream: bloc.serviciosStram,
        builder:
            (BuildContext context, AsyncSnapshot<List<Servicio>> snapshot) {
          if (snapshot.hasData) {
            Set<Servicio> set = Set.from(snapshot.data);
            set.forEach((element) => element.check = false);
            servicios.addAll(snapshot.data);
            return _construirListaServicio();
          } else {
            return Container(
                height: 400.0,
                child: Center(child: CircularProgressIndicator()));
          }
        },
      );
    } else {
      return _construirListaServicio();
    }
  }

  Widget _construirListaServicio() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: servicios.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text(servicios[index].nombre),
          value: servicios[index].check,
          onChanged: (valor) {
            setState(() {
              servicios[index].check = valor;
            });
          },
        );
      },
    );
  }

  Future<Null> _obtenerPagina() async {
    _servicioPage++;
    final bloc = Provider.ofServicioBloc(context);
    servicosProvider.getServicios(servicioPage: _servicioPage, bloc: bloc);
    setState(() {});
    return null;
  }

  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                maxLines: 8,
                controller: _controllerTextEditing,
                decoration: InputDecoration(
                    icon: Icon(Icons.report_problem),
                    hintText: "",
                    border: OutlineInputBorder(),
                    labelText: 'Describe su problema? *'),
                onSaved: (String value) {
                  setState(() {
                    _problema = value;
                  });
                  print(value);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor ingrese, el su problema a atender.';
                  }
                  return null;
                },
              ),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      print("paso por aca ${_controllerTextEditing.text}");
                      servicios.forEach((val) {
                        print(val);
                      });
                      final bloc = Provider.ofServicioBloc(context);
                      final requemiento = RequerimientoRequest(
                          notas: _controllerTextEditing.text,
                          servicios: servicios.where((val) => val.check).toList(),
                          idCliente: "1");
                      servicosProvider.crearRequerimiento(request: requemiento);
                      StreamBuilder(
                        stream: bloc.requerimientoStram,
                        builder: (BuildContext context,
                            AsyncSnapshot<MensajeRespuesta> snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot);
                            return null;
                          } else {
                            return Container(
                                height: 400.0,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        },
                      );
                    }
                  },
                  child: Text('Enviar requerimiento'),
                ),
              ),
            ],
          )),
    );
    /*],
        );*/
  }
}
