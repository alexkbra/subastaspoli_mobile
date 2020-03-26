import 'package:flutter/material.dart';


class CustomerServicePage extends StatefulWidget {
  CustomerServicePage({Key key}) : super(key: key);
  static final pageName = "service_client";

  _CustomerServicePageState createState() => _CustomerServicePageState();
}

class _CustomerServicePageState extends State<CustomerServicePage> {

  

  String _nombre = '';
  String _email = '';
  String _fecha = '';
  String _opcionSelecionada = 'Volar';

  List<String> _poderes = ['Volar', 'Rayos x','Super Aliento','Super Fuerza'];

  

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicio al cliente'),
      ),
       body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearTipoServicio(),
          Divider(),
          _crearInput(),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
           Divider(),
          _crearFecha(context),
          Divider(),
          _crearDropdown(),
          Divider(),
          _crearPersona(),
        ],
      ),
    );
  }

  Widget _crearInput() {

    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        counter: Text('Cantidad de letras ${_nombre.length}'),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        helperText: 'Solo es el nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon( Icons.account_circle )
      ),
      onChanged: (valor){
        setState(() {
           _nombre = valor;
          print(_nombre);
        });
      },
    );

  }

  Widget _crearPersona() {

    return ListTile(
      title: Text('Nombre es: $_nombre '),
      subtitle: Text('Email es: $_email '),
      trailing: Text(_opcionSelecionada),
    );


  }

  Widget _crearEmail() {

    return TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Email',
        labelText: 'Email',
        helperText: 'Solo es el Email',
        suffixIcon: Icon(Icons.email),
        icon: Icon( Icons.email )
      ),
      onChanged: (valor){
        setState(() {
           _email = valor;
          print(_email);
        });
      },
    );

  }

  Widget _crearPassword() {
    
    return TextField(
      //autofocus: true,
      //textCapitalization: TextCapitalization.sentences,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Password',
        labelText: 'Password',
        helperText: 'Solo es el Password',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon( Icons.lock )
      ),
      onChanged: (valor){
        setState(() {
           _email = valor;
          print(_email);
        });
      },
    );
  }

  Widget _crearFecha(BuildContext context) {

    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        helperText: 'Solo es el Fecha de nacimiento',
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon( Icons.calendar_today )
      ),
      onTap: (){

        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate( context );

      },
    );

  }

  void _selectDate(BuildContext context) async {

    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
      locale: Locale('es'),
    );

    if(picked != null){
      setState(() {
        _fecha = picked.toString(); 
        _inputFieldDateController.text = _fecha;
      });
    }

  }

  List<DropdownMenuItem<String>> _getOpcionesDropdown() {
    List<DropdownMenuItem<String>> list = new  List();

    _poderes.forEach( (poder){
      list.add( DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });

    return list;
  }

  Widget _crearDropdown() {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0,),
        Expanded(
          child: DropdownButton(
            value: _opcionSelecionada,
            items: _getOpcionesDropdown(),
            onChanged: (opt){
              print(opt);
              setState(() {
                _opcionSelecionada  = opt;
              });
            },
          ),
        ),
      ],
    );
    
    
    
    
  }

  Widget _crearTipoServicio() {

    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0,),
        Expanded(
          child: DropdownButton(
            value: _opcionSelecionada,
            items: _getOpcionesDropdown(),
            onChanged: (opt){
              print(opt);
              setState(() {
                _opcionSelecionada  = opt;
              });
            },
          ),
        ),
      ],
    ); 

  }

}