import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/models/lotes_model.dart';
import 'package:subastaspoli_mobile/src/models/lotes_to_animales_model.dart';
import 'package:subastaspoli_mobile/src/providers/lotes_to_animales_provider.dart';
import 'package:subastaspoli_mobile/src/utils/menu_bottom_navigation_bar_util.dart';
import 'package:subastaspoli_mobile/src/utils/utils.dart';
import 'package:subastaspoli_mobile/src/widgets/card_lote_to_animal_widget.dart';

class DetalleLotesPage extends StatefulWidget {
  static final pageName = "detalle_lotes";

  @override
  _DetalleLotesPageState createState() => _DetalleLotesPageState();
}

class _DetalleLotesPageState extends State<DetalleLotesPage> {
  ScrollController _scrollController = new ScrollController();
  final LotesToAnimalesProvider lotesToAnimalesProvider =
      new LotesToAnimalesProvider();
  Utils _util = Utils();
  List<LotesToAnimalesModel> _listLotesToAnimales =
      new List<LotesToAnimalesModel>();
  int _pageNumber;
  bool _isLoading = false;
  LotesModel _lote;

  @override
  void initState() {
    super.initState();
    _listLotesToAnimales.clear();
    _pageNumber = 0;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _obtenerPagina();
      }
    });
  }

  Future<Null> _fetchData() async {
    _listLotesToAnimales.clear();
    _pageNumber = 0;
    setState(() {});
  }

  Future<Null> _obtenerPagina() async {
    _pageNumber++;
    final bloc = Provider.ofLotesToAnimalesBloc(context);
    _isLoading = true;
    lotesToAnimalesProvider.getLotesToAnimalByLote(
        context, bloc, _pageNumber, _lote.id);
  }

  @override
  Widget build(BuildContext context) {
    _lote = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(_lote),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitulo(context, _lote),
              _descripcion(_lote),
              _posterSubTitulo(context, _lote),
              _swiperTarjetas(context),
              _crearLoading(),
            ]),
          )
        ],
      ),
      bottomNavigationBar: MenuBottomNavigationBarUtil(lote: _lote),
    );
  }

  Widget _swiperTarjetas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.ofLotesToAnimalesBloc(context);
    if (_listLotesToAnimales.isEmpty) {
      lotesToAnimalesProvider.getLotesToAnimalByLote(
          context, bloc, _pageNumber, _lote.id);
    }
    final streamBuilder = StreamBuilder(
      stream: bloc.lotesStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<LotesToAnimalesModel>> snapshot) {
        if (snapshot.hasData) {
          _listLotesToAnimales = snapshot.data;
          _isLoading = false;
          return Container(
            height: size.height * 0.8,
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return CardLotesToAnimal(loteToAnimal: snapshot.data[index]);
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

  Widget _posterSubTitulo(BuildContext context, LotesModel lote) {
    return Container(
      child: Center(
        child: Text("Animales", style: TextStyle(fontSize:  18.0),),
      )
    );
  }

  Widget _crearAppbar(LotesModel lotes) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blueGrey,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          lotes.nombre,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: _util.imageFromBase64String(lotes.imagenUrl).image,
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, LotesModel lote) {
    return Container(
      child: Row(
        children: <Widget>[
          Hero(
            tag: lote.id,
            child: ClipRRect(
                child: ((lote.videoUrl == null ? true : lote.videoUrl.isEmpty)
                    ? Container()
                    : _util.videoEvento(lote.videoUrl, context))),
          ),
        ],
      ),
    );
  }

  Widget _descripcion(LotesModel lote) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(lote.decripcion, textAlign: TextAlign.justify),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Text(
                  'Número: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  lote.numero,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Raza: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  lote.raza,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Cantidad animales: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  lote.cantidadAnimales.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Peso promedio: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  lote.pesopromedio.toString(),
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
                  lote.pesototallote.toString(),
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
                  lote.pesobaseporkg.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ));
  }
}
