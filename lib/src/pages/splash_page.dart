import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:subastaspoli_mobile/src/pages/home_page.dart';
import 'package:subastaspoli_mobile/src/pages/login_v2_page.dart';
import 'package:subastaspoli_mobile/src/utils/session.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final _session = Session();

  @override
  void initState() {
    super.initState();
    this.chaeck();
  }

  chaeck() async{
    final data = await _session.get();
    if(data == null){
      Navigator.pushNamed(context, HomePage.pageName);
    }else{
      Navigator.pushNamed(context, LoginV2Page.pageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(child: CupertinoActivityIndicator(radius: 15,)),
    );
  }
}