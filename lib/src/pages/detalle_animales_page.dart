import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/models/contenidos_model.dart';
import 'package:subastaspoli_mobile/src/models/lotes_to_animales_model.dart';
import 'package:subastaspoli_mobile/src/providers/contenidos_provider.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:subastaspoli_mobile/src/widgets/card_animales_contenido_widget.dart';

class DetalleAnimalesPage extends StatefulWidget {
  static final pageName = "detalle_animales";

  @override
  _DetalleAnimalesPageState createState() => _DetalleAnimalesPageState();
}

class _DetalleAnimalesPageState extends State<DetalleAnimalesPage> {
  ScrollController _scrollController = new ScrollController();
  final ContenidosProvider contenidosProvider = new ContenidosProvider();
  Utils _util = Utils();
  List<ContenidosModel> _listContenidos = new List<ContenidosModel>();
  int _pageNumber;
  bool _isLoading = false;
  LotesToAnimalesModel _lotesToAnimales;

  @override
  void initState() {
    super.initState();
    _listContenidos.clear();
    _pageNumber = 0;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _obtenerPagina();
      }
    });
  }

  Future<Null> _fetchData() async {
    _listContenidos.clear();
    _pageNumber = 0;
    setState(() {});
  }

  Future<Null> _obtenerPagina() async {
    _pageNumber++;
    final bloc = Provider.ofContenidoBloc(context);
    _isLoading = true;
    contenidosProvider.getContenidos(
        context, bloc, _pageNumber, _lotesToAnimales.animales.id, 'Animales');
  }

  @override
  Widget build(BuildContext context) {
    _lotesToAnimales = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(_lotesToAnimales),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitulo(context, _lotesToAnimales),
              _descripcion(_lotesToAnimales),
              _posterSubTitulo(context, _lotesToAnimales),
              _swiperTarjetas(context),
              _crearLoading(),
            ]),
          )
        ],
      ),
    );
  }

  Widget _swiperTarjetas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.ofContenidoBloc(context);
    if (_listContenidos.isEmpty) {
      contenidosProvider.getContenidos(
          context, bloc, _pageNumber, _lotesToAnimales.animales.id, 'Animales');
    }
    final streamBuilder = StreamBuilder(
      stream: bloc.contenidoStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<ContenidosModel>> snapshot) {
        if (snapshot.hasData) {
          _listContenidos = snapshot.data;
          _isLoading = false;
          return Container(
            height: size.height * 0.8,
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return CardAnimalesContenido(contenido: snapshot.data[index]);
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

  Widget _posterSubTitulo(
      BuildContext context, LotesToAnimalesModel lotesToAnimales) {
    return Container(
        child: Center(
      child: Text(
        "Contenido",
        style: TextStyle(fontSize: 18.0),
      ),
    ));
  }

  Widget _crearAppbar(LotesToAnimalesModel lotesToAnimales) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blueGrey,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          lotesToAnimales.animales.descripcion,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: _util
              .imageFromBase64String(lotesToAnimales.animales.imagenUrl)
              .image,
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(
      BuildContext context, LotesToAnimalesModel lotesToAnimales) {
    return Container(
      child: Row(
        children: <Widget>[
          Hero(
            tag: lotesToAnimales.animales.id,
            child: ClipRRect(
                child: /*((lotesToAnimales.animales.videoUrl == null
                        ? true
                        : lotesToAnimales.animales.videoUrl.isEmpty)
                    ? */
                    Container()
                    /*: _util.videoEvento(
                        lotesToAnimales.animales.videoUrl, context))*/),
          ),
        ],
      ),
    );
  }

  Widget _descripcion(LotesToAnimalesModel lotesToAnimales) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        lotesToAnimales.animales.descripcion,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
