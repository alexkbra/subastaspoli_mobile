import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/models/eventos_model.dart';
import 'package:subastaspoli_mobile/src/models/subastas_model.dart';
import 'package:subastaspoli_mobile/src/providers/subastas_provider.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';

import 'package:subastaspoli_mobile/src/widgets/card_subasta_widget.dart';

class DetalleEventoPage extends StatefulWidget {
  static final pageName = "detalle_evento";

  @override
  _DetalleEventoPageState createState() => _DetalleEventoPageState();
}

class _DetalleEventoPageState extends State<DetalleEventoPage> {
  ScrollController _scrollController = new ScrollController();
  final SubastasProvider subastasProvider = new SubastasProvider();
  Utils _util = Utils();
  List<SubastasModel> _listSubastas = new List<SubastasModel>();
  final Session _session = new Session();
  int _pageNumber;
  bool _isLoading = false;
  EventosModel _evento;

  @override
  void initState() {
    super.initState();
    _listSubastas.clear();
    _pageNumber = 0;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _obtenerPagina();
      }
    });
  }

  Future<Null> _fetchData() async {
    _listSubastas.clear();
    _pageNumber = 0;
    setState(() {});
  }

  Future<Null> _obtenerPagina() async {
    _pageNumber++;
    final bloc = Provider.ofSubastasBloc(context);
    _isLoading = true;
    subastasProvider.getSubastasByEventos(
        context, bloc, _pageNumber, _evento.id);
  }

  @override
  Widget build(BuildContext context) {
    _evento = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(_evento),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _posterTitulo(context, _evento),
            _descripcion(_evento),
            _posterSubTitulo(context, _evento),
            _swiperTarjetas(context),
            _crearLoading(),
          ]),
        )
      ],
    ));
  }

  Widget _swiperTarjetas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.ofSubastasBloc(context);
    if (_listSubastas.isEmpty) {
      subastasProvider.getSubastasByEventos(
          context, bloc, _pageNumber, _evento.id);
    }
    final streamBuilder = StreamBuilder(
      stream: bloc.subastasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<SubastasModel>> snapshot) {
        if (snapshot.hasData) {
          _listSubastas = snapshot.data;
          _isLoading = false;
          return Container(
            height: size.height * 0.8,
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return CardSubastas(subasta: snapshot.data[index]);
              },
            ),
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );

    return RefreshIndicator(
        onRefresh: _fetchData,
        child: Container(height: size.height * 0.8, child: streamBuilder));
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
            height: 10.0,
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _crearAppbar(EventosModel evento) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blueGrey,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          evento.nombre,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: _util.imageFromBase64String(evento.imagenUrl).image,
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, EventosModel evento) {
    return Container(
      child: Row(
        children: <Widget>[
          Hero(
            tag: evento.id,
            child: ClipRRect(
                child:
                    (/*(evento.videoUrl == null ? true : evento.videoUrl.isEmpty)
                        ? */
                        Container()
                    /*: _util.videoEvento(evento.videoUrl, context)*/)),
          ),
        ],
      ),
    );
  }

  Widget _posterSubTitulo(BuildContext context, EventosModel evento) {
    return Container(
        child: Center(
      child: Text(
        "Subastas",
        style: TextStyle(fontSize: 18.0),
      ),
    ));
  }

  Widget _descripcion(EventosModel evento) {
    final f = new DateFormat('yyyy-MM-dd hh:mm a');
    print(evento.fechainicio);
    print(evento.fechafinal);
    final fechainicio = f.format(DateTime.parse(evento.fechainicio));
    final fechafinal = f.format(DateTime.parse(evento.fechafinal));

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(evento.decripcion == null ? "" : evento.decripcion,
                textAlign: TextAlign.justify),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Text(
                  'Fecha inicial: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  fechainicio,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Fecha final: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  fechafinal,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ));
  }
}
