import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:subastaspoli_mobile/src/api/auth_api.dart';
import 'package:subastaspoli_mobile/src/models/puja_model.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';
import 'package:subastaspoli_mobile/src/utils/socket_client.dart';
import 'package:subastaspoli_mobile/src/widgets/circle_login.dart';
import 'package:subastaspoli_mobile/src/widgets/input_text_loginv2.dart';

class PujaPage extends StatefulWidget {
  PujaPage({Key key}) : super(key: key);
  static final pageName = "puja_page";
  @override
  _PujaPageState createState() => _PujaPageState();
}

class _PujaPageState extends State<PujaPage> {
  final _formKey = GlobalKey<FormState>();
  final _pujaVM = PujaVM();
  final _authAPI = AuthApi();
  var _isFetching = false;
  final _socketClient = new SocketClient();
  final Session _session = new Session();
  var channel;
  double _valorActual = 200.0;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  void dispose(){
    super.dispose();
    _socketClient.destroySocket();
  }

  _connectWebSocket() async {
    final dataSession = await _session.get();
    if (dataSession != null &&
        dataSession['idToken'] != null &&
        dataSession['idToken'].toString().isNotEmpty) {
          await _socketClient.destroySocket();
          await _socketClient.connectSocket01(token: dataSession['idToken']);
          print("Listo");


        }
  }

  _submit() async {
    if (_isFetching) return;
    final isValidate = _formKey.currentState.validate();
    if (isValidate) {
      setState(() {
        _isFetching = true;
      });
      setSendMessage();
      /*final isOk = await _authAPI.login(context, _pujaVM);
      setState(() {
        _isFetching = false;
      });
      if(isOk ){
        

      }*/
    }
  }

  setSendMessage() async {
    final isEvento = await _session.getEntidad(key: "eventoid");
    final isSubasta = await _session.getEntidad(key: "subastaid");
    final isLote = await _session.getEntidad(key: "loteid");
    final token = await _session.get();
    final data = {"idEvento":isEvento,"idSubasta": isSubasta, "idLote": isLote,"valor": _pujaVM.valor, "token": token["idToken"] };
    _socketClient.sendChatMessage(jsonEncode(data));
    _isFetching = false;
    //channel.sink.add(jsonEncode(data));
  }


  setSendMessageInit() async {
    final isEvento = await _session.getEntidad(key: "eventoid");
    final isSubasta = await _session.getEntidad(key: "subastaid");
    final isLote = await _session.getEntidad(key: "loteid");
    final token = await _session.get();
    final data = {"idEvento":isEvento,"idSubasta": isSubasta, "idLote": isLote,"valor": null, "token": token["idToken"] };
    _socketClient.sendChatMessage(jsonEncode(data));
    _isFetching = false;
    //channel.sink.add(jsonEncode(data));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //setSendMessageInit();
    //channel = IOWebSocketChannel.connect('wss://192.168.39.126:8080/websocket/puja');
    //setSendMessage();
    //_socketClient.subscribes();
    return Scaffold(
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
                              /*StreamBuilder(
                                stream: channel.stream,
                                builder: (context, snapshot) {
                                  return Text(snapshot.hasData
                                      ? '${snapshot.data}'
                                      : '');
                                },
                              ),*/
                              Text(
                                "Puja Actual \n $_valorActual",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w300),
                              )
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
                                          _pujaVM.valor = double.parse(text);
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
                                  onPressed: () => _submit(),
                                  child: Text(
                                    "Ingresar",
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
