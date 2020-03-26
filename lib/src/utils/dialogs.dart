import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:subastaspoli_mobile/src/models/lotes_model.dart';

class Dialogs {
  static void alertInfo(BuildContext context,
      {title = 'información', message = '', String redirectPageName = null,LotesModel lote}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            content: Text(message,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () { 
                  Navigator.pop(context);
                  if(redirectPageName != null){
                    if(lote == null){
                      Navigator.pushNamed(context, redirectPageName);
                    }else{
                      Navigator.pushNamed(context, redirectPageName, arguments: lote);
                    }
                  }
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  static void alertError(BuildContext context,
      {title = 'Error', message = '', VoidCallback onOk}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            content: Text(message,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }
}
