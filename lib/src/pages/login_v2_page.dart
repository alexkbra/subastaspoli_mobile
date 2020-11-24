import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:subastaspoli_mobile/src/api/auth_api.dart';
import 'package:subastaspoli_mobile/src/bloc/provider.dart';
import 'package:subastaspoli_mobile/src/models/loginVM.dart';
import 'package:subastaspoli_mobile/src/models/lotes_model.dart';
import 'package:subastaspoli_mobile/src/pages/detalle_lotes_page.dart';
import 'package:subastaspoli_mobile/src/pages/home_page.dart';
import 'package:subastaspoli_mobile/src/pages/puja_page.dart';
import 'package:subastaspoli_mobile/src/pages/sing_up_page.dart';
import 'package:subastaspoli_mobile/src/utils/dialogs.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';
import 'package:subastaspoli_mobile/src/widgets/circle_login.dart';
import 'package:subastaspoli_mobile/src/widgets/input_text_loginv2.dart';

class LoginV2Page extends StatefulWidget {
  LoginV2Page({Key key}) : super(key: key);
  static final pageName = "loginV2";
  @override
  _LoginV2PageState createState() => _LoginV2PageState();
}

class _LoginV2PageState extends State<LoginV2Page> {
  final _formKey = GlobalKey<FormState>();
  final _loginVM = LoginVM();
  final _authAPI = AuthApi();
  var _isFetching = false;
  final Session _session = new Session();

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {
    if (_isFetching) return;
    final isValidate = _formKey.currentState.validate();
    if (isValidate) {
      setState(() {
        _isFetching = true;
      });
      _loginVM.rememberMe = false;
      final isOk = await _authAPI.login(context, _loginVM);
      if (isOk) {
        final isEvento = await _session.getEntidad(key: "eventoid");
        final isSubasta = await _session.getEntidad(key: "subastaid");
        final isLote = await _session.getEntidad(key: "loteid");
        final whereIAmNow = await _session.getEntidad(key: "whereIAmNow");
        if (isEvento != null &&
            isSubasta != null &&
            isLote != null &&
            whereIAmNow == 1) {
          final token = await _session.get();
          switch (token["clientStatus"]) {
            case "anonymousClientNotBidder":
              {
                Dialogs.alertError(context,
                    message: "Debe de ingresar como pujador");
              }
              break;
            case "CD001":
              {
                Dialogs.alertError(context,
                    message:
                        "Su estado debe de ser autorizado para empezar en la puja  ");
              }
              break;
            case "CD002":
              {
                Navigator.pushNamed(context, PujaPage.pageName);
              }
              break;
          }
        } else {
          Navigator.pushNamed(context, HomePage.pageName);
        }
      }
      setState(() {
        _isFetching = false;
      });
    }
  }

  _determinarSession() async {
    final dataSession = await _session.get();
    if (dataSession != null &&
        dataSession['idToken'] != null &&
        dataSession['idToken'].toString().isNotEmpty) {
      LotesModel _lote = ModalRoute.of(context).settings.arguments;
      Navigator.pushNamed(context, DetalleLotesPage.pageName, arguments: _lote);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blocLogin = Provider.ofLoginBloc(context);
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
                              margin: EdgeInsets.only(top: size.width * 0.3),
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
                            Text(
                              "Hola \n usuario bacuno",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
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
                                      label: "Usuario",
                                      inputType: TextInputType.emailAddress,
                                      validator: (String text) {
                                        if (text.isEmpty) {
                                          return "Usuario requerido";
                                        }
                                        _loginVM.username = text;
                                        blocLogin.changeEmail(text);
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    InputTextLoginv2(
                                      label: "Contraseña",
                                      isSecure: true,
                                      validator: (String text) {
                                        if (text.isEmpty && text.length < 5) {
                                          return "Contraseña invalida";
                                        }
                                        _loginVM.password = text;
                                        blocLogin.changePassword(text);
                                        return null;
                                      },
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Eres nuevo?",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                                CupertinoButton(
                                    child: Text(
                                      "registrate",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.blueGrey),
                                    ),
                                    onPressed: () => Navigator.pushNamed(
                                        context, SingUpPage.pageName))
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            )
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
                  onPressed: () => Navigator.pop(context),
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
    ));
  }
}
