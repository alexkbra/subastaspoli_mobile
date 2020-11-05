import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/models/lotes_model.dart';
import 'package:subastaspoli_mobile/src/models/subastas_model.dart';
import 'package:subastaspoli_mobile/src/providers/lotes_provider.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:subastaspoli_mobile/src/widgets/card_lote_widget.dart';

class DetalleSubastaPage extends StatefulWidget {
  static final pageName = "detalle_subasta";

  @override
  _DetalleSubastaPageState createState() => _DetalleSubastaPageState();
}

class _DetalleSubastaPageState extends State<DetalleSubastaPage> {
  ScrollController _scrollController = new ScrollController();
  final LotesProvider lotesProvider = new LotesProvider();
  Utils _util = Utils();
  List<LotesModel> _listLotes = new List<LotesModel>();
  final Session _session = new Session();
  int _pageNumber;
  bool _isLoading = false;
  SubastasModel _subasta;

  @override
  void initState() {
    super.initState();
    _listLotes.clear();
    _pageNumber = 0;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _obtenerPagina();
      }
    });
  }

  Future<Null> _fetchData() async {
    _listLotes.clear();
    _pageNumber = 0;
    setState(() {});
  }

  Future<Null> _obtenerPagina() async {
    _pageNumber++;
    final bloc = Provider.ofLotesBloc(context);
    _isLoading = true;
    lotesProvider.getLotesBySubastas(context, bloc, _pageNumber, _subasta.id);
  }

  @override
  Widget build(BuildContext context) {
    _subasta = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(_subasta),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _posterTitulo(context, _subasta),
            _descripcion(_subasta),
            _posterSubTitulo(context, _subasta),
            _swiperTarjetas(context),
            _crearLoading(),
          ]),
        )
      ],
    ));
  }

  Widget _swiperTarjetas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.ofLotesBloc(context);
    if (_listLotes.isEmpty) {
      lotesProvider.getLotesBySubastas(context, bloc, _pageNumber, _subasta.id);
    }
    final streamBuilder = StreamBuilder(
      stream: bloc.lotesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<LotesModel>> snapshot) {
        if (snapshot.hasData) {
          _listLotes = snapshot.data;
          _isLoading = false;
          return Container(
            height: size.height * 0.8,
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return CardLotes(lote: snapshot.data[index]);
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

  Widget _posterSubTitulo(BuildContext context, SubastasModel subasta) {
    return Container(
      child: Center(
        child: Text("Lotes", style: TextStyle(fontSize:  18.0),),
      )
    );
  }

  Widget _crearAppbar(SubastasModel subasta) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blueGrey,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          subasta.nombre,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: _util.imageFromBase64String(subasta.imagenUrl).image,
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, SubastasModel evento) {
    return Container(
      child: Row(
        children: <Widget>[
          Hero(
            tag: evento.id,
            child: ClipRRect(
                child:
                    (/*(evento.videoUrl == null ? true : evento.videoUrl.isEmpty)
                        ?*/ 
                        Container()
                        /*: _util.videoEvento(evento.videoUrl, context)*/)),
          ),
        ],
      ),
    );
  }

  Widget _descripcion(SubastasModel subasta) {
    final f = new DateFormat('yyyy-MM-dd hh:mm a');
    print(subasta.fechainicio);
    print(subasta.fechafinal);
    final fechainicio = f.format(DateTime.parse(subasta.fechainicio));
    final fechafinal = f.format(DateTime.parse(subasta.fechafinal));

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(subasta.decripcion, textAlign: TextAlign.justify),
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
            Row(
              children: <Widget>[
                Text(
                  'Valor inicial: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subasta.valorinicial.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Valor actual: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subasta.valoractual.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Peso base por (kg): ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subasta.pesobaseporkg.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Peso total lote: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subasta.pesototallote.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ));
  }
}
