import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/models/eventos_model.dart';
import 'package:subastaspoli_mobile/src/providers/eventos_provider.dart';
import 'package:subastaspoli_mobile/src/utils/menu_drawer_util.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';
import 'package:subastaspoli_mobile/src/utils/socket_client.dart';
import 'package:subastaspoli_mobile/src/utils/ui_image_data.dart';
import 'package:subastaspoli_mobile/src/widgets/card_evento_widget.dart';
//import 'package:hometechclaim_mobile/src/widgets/card_swiper_novedades_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static final pageName = "/";

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  final EventosProvider eventosProvider = new EventosProvider();
  final Session _session = new Session();

  List<EventosModel> _listEventos = new List<EventosModel>();
  int _pageNumber;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _listEventos.clear();
    _setSeesion();
    _pageNumber = 0;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _obtenerPagina();
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _fetchData() async {
    _listEventos.clear();
    _pageNumber = 0;
    setState(() {});
  }

  Future<Null> _obtenerPagina() async {
    _pageNumber++;
    final bloc = Provider.ofEventosBloc(context);
    _isLoading = true;
    eventosProvider.getEventos(context, bloc, _pageNumber);
  }

  _setSeesion() async {
    _session.putEntidad(key: "eventoid", id: null);
    _session.putEntidad(key: "subastaid", id: null);
    _session.putEntidad(key: "loteid", id: null);
  }

  

  @override
  Widget build(BuildContext context) {
    //TODO: Borrar cuando ya tengamos todo el incio bien
    //_session.deleteAll();
    
    //TODO: esto si
    //_session.deleteAllEntidad();
    //_setSeesion();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Subastas'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              _swiperTarjetas(context),
              _crearLoading(),
            ],
          ),
        ),
        drawer: MenuDrawerUtil(),
      ),
    );
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

  Widget _swiperTarjetas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.ofEventosBloc(context);
    if (_listEventos.isEmpty) {
      eventosProvider.getEventos(context, bloc, _pageNumber);
    }
    final streamBuilder = StreamBuilder(
      stream: bloc.eventosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<EventosModel>> snapshot) {
        if (snapshot.hasData) {
          _listEventos = snapshot.data;
          _isLoading = false;
          return Container(
            height: size.height * 0.8,
            child: ListView.builder(
              itemCount: snapshot.data.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return CardEvento(
                    galleryItems: UIImageData.postList[index],
                    evento: snapshot.data[index]);
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
}
