import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:subastaspoli_mobile/src/api/auth_api.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/models/puja_model.dart';
import 'package:subastaspoli_mobile/src/pages/home_page.dart';
import 'package:subastaspoli_mobile/src/providers/push_notifications_provider.dart';
import 'package:subastaspoli_mobile/src/utils/dialogs.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';
import 'package:subastaspoli_mobile/src/widgets/circle_login.dart';
import 'package:subastaspoli_mobile/src/widgets/input_text_loginv2.dart';

class PujaPage extends StatefulWidget {
  PujaPage({Key key}) : super(key: key);
  static final pageName = "puja_page";
  @override
  _PujaPageState createState() => _PujaPageState();
}

class _PujaPageState extends State<PujaPage> {
  final pushProvider = PushNotificationProvider.instance;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _authAPI = AuthApi();
  var _isFetching = false;
  final Session _session = new Session();
  String _valorActual = "0.0";

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _pujaInit();
  }

  _pujaInit() async {
    if (_isFetching) return;

    final isEvento = await _session.getEntidad(key: "eventoid");
    final isSubasta = await _session.getEntidad(key: "subastaid");
    final isLote = await _session.getEntidad(key: "loteid");
    final tokenDis = await _session.getEntidad(key: "tokenDis");
    final token = await _session.get();

    setState(() {
      _isFetching = true;
    });

    final pujaVM = PujaVM(
        idEventos: isEvento.toString(),
        idSubasta: isSubasta.toString(),
        idLote: isLote.toString(),
        token: token['idToken'].toString(),
        dispositivoId: tokenDis,
        valor: _valorActual);

    final initPuja = await _authAPI.pujarInit(pujaVM);
    setState(() {
      _isFetching = false;
    });
    _valorActual = initPuja;
  }

  @override
  void dispose() {
    super.dispose();
    pushProvider.dispose();
  }

  _submit(BuildContext context) async {
    if (_isFetching) return;

    final isEvento = await _session.getEntidad(key: "eventoid");
    final isSubasta = await _session.getEntidad(key: "subastaid");
    final isLote = await _session.getEntidad(key: "loteid");
    final tokenDis = await _session.getEntidad(key: "tokenDis");
    final token = await _session.get();

    final isValidate = _formKey.currentState.validate();
    if (isValidate) {
      setState(() {
        _isFetching = true;
      });

      final pujaVM = PujaVM(
          idEventos: isEvento.toString(),
          idSubasta: isSubasta.toString(),
          idLote: isLote.toString(),
          token: token['idToken'].toString(),
          dispositivoId: tokenDis,
          valor: _valorActual);

      final isOk = await _authAPI.pujar(context, pujaVM);
      setState(() {
        _isFetching = false;
      });
      if (isOk) {
        Dialogs.alertInfo(context, message: "Puja realizada por $_valorActual");
      } else {
        Dialogs.alertError(context, message: "Error al realizar la puja");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTemp = ModalRoute.of(context).settings.arguments ??
        Text(
          "Puja Actual $_valorActual",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        );

    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -size.width * 0.22,
                top: -size.width * 0.4,
                child: CircleLogin(
                  radius: size.width * 0.45,
                  colors: [
                    Colors.blueGrey,
                    Colors.grey,
                  ],
                ),
              ),
              Positioned(
                left: -size.width * 0.15,
                top: -size.width * 0.34,
                child: CircleLogin(
                  radius: size.width * 0.35,
                  colors: [
                    Colors.blueAccent,
                    Colors.blueGrey,
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                    width: size.width,
                    height: size.height,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                width: 90,
                                height: 90,
                                margin: EdgeInsets.only(top: size.width * 0.5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 25)
                                    ]),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              StreamBuilder<Text>(
                                  stream: pushProvider.mensajes,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Text> snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data;
                                    } else {
                                      return textTemp;
                                    }
                                  }),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 300,
                                  minWidth: 300,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      InputTextLoginv2(
                                        label: "Puja",
                                        inputType: TextInputType.number,
                                        validator: (String text) {
                                          if (text.isEmpty) {
                                            return "Puja requerido";
                                          }
                                          _valorActual = text;
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 300,
                                  minWidth: 300,
                                ),
                                child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(vertical: 17),
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(4),
                                  onPressed: () => _submit(context),
                                  child: Text(
                                    "Pujar",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 300,
                                  minWidth: 300,
                                ),
                                child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(vertical: 17),
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(4),
                                  onPressed: () {
                                    final bloc = Provider.ofLoginBloc(context);
                                    bloc.changeEmail(null);
                                    _session.deleteAll();
                                    pushProvider.dispose();
                                    Navigator.pushNamed(
                                        context, HomePage.pageName);
                                  },
                                  child: Text(
                                    "Cerrar sesión",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              Positioned(
                left: 10,
                top: 15,
                child: SafeArea(
                  child: CupertinoButton(
                    padding: EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black12,
                    onPressed: () {
                      Navigator.pushNamed(context, HomePage.pageName);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              _isFetching
                  ? Positioned.fill(
                      child: Container(
                      color: Colors.black45,
                      child: Center(
                          child: CupertinoActivityIndicator(
                        radius: 15,
                      )),
                    ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
