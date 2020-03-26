import 'package:flutter/material.dart';
import 'package:subastaspoli_mobile/src/models/servicio_model.dart';

class RequerimientoPage extends StatefulWidget {

  static final pageName = "requerimiento";

  @override
  _RequerimientoPageState createState() => _RequerimientoPageState();
}

class _RequerimientoPageState extends State<RequerimientoPage> {
  final _formKey = GlobalKey<FormState>();

  Servicio servicio;

  @override
  Widget build(BuildContext context) {

    Servicio servicio = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(' Servicio al cliente '),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[
            Text('Describa su problema, por favor con ${servicio.nombre}'),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.report_problem),
                        hintText: 'Describe su problema?',
                        labelText: '*',
                      ),
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor ingrese, el su problema a atender.';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.

            

                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Enviar requerimiento'),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
