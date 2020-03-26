import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:subastaspoli_mobile/src/api/auth_api.dart';
import 'package:subastaspoli_mobile/src/models/managedUserVM.dart';
import 'package:subastaspoli_mobile/src/pages/login_v2_page.dart';
import 'package:subastaspoli_mobile/src/widgets/circle_login.dart';
import 'package:subastaspoli_mobile/src/widgets/input_text_loginv2.dart';
import '../utils/dialogs.dart';

class SingUpPage extends StatefulWidget {
  SingUpPage({Key key}) : super(key: key);
  static final pageName = "singUpPage";
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _managerUser = ManagedUserVM();
  final _authAPI = AuthApi();
  var _isFetching = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {
    final isValidate = _formKey.currentState.validate();
    if (isValidate) {
      setState(() {
        _isFetching = true;
      });
      if (_managerUser.password != _managerUser.password2) {
        Dialogs.alertError(context, message: "Contraseñas no son iguasles");
        return;
      }
      _managerUser.activated = false;
      _managerUser.langKey = 'es';
      final isOk = await _authAPI.register(context, _managerUser);
      setState(() {
        _isFetching = false;
      });
      if (isOk) {
        Dialogs.alertInfo(context,
            message:
                "¡Registro guardado!, Por favor, revise su correo electrónico para confirmar.",
            redirectPageName: LoginV2Page.pageName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  height: size.height + 100,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              "Registro",
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
                                        if (text.isEmpty &&
                                            !RegExp(r'^[_.@A-Za-z0-9-]*$')
                                                .hasMatch(text)) {
                                          return "Usuario invalido";
                                        }
                                        _managerUser.login = text;
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InputTextLoginv2(
                                      label: "Correo electrónico",
                                      inputType: TextInputType.emailAddress,
                                      validator: (String text) {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regExp = new RegExp(pattern);
                                        if (!regExp.hasMatch(text)) {
                                          return 'Email no es correco';
                                        }
                                        if (text.isEmpty) {
                                          return "Correo requerido";
                                        }
                                        _managerUser.email = text;
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InputTextLoginv2(
                                      label: "Contraseña",
                                      isSecure: true,
                                      validator: (String text) {
                                        if (text.isEmpty && text.length < 5) {
                                          return "Contraseña invalida";
                                        }
                                        _managerUser.password = text;
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InputTextLoginv2(
                                      label:
                                          "Confirmación de la nueva contraseña",
                                      isSecure: true,
                                      validator: (String text) {
                                        if (text.isEmpty && text.length < 5) {
                                          return "Contraseña invalida";
                                        }
                                        _managerUser.password2 = text;
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
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
                                  "Crear la cuenta",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
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
