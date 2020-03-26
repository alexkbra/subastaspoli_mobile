
class LotesModelList{
  List<LotesModel> items = new List();
  LotesModelList();
  LotesModelList.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    for(var item in jsonList){
      final lote = new LotesModel.fromJson(item);
      items.add(lote);
    }
  }
}

class LotesModel {
  int _cantidadAnimales;
  Clasificacionlote _clasificacionlote;
  String _decripcion;
  int _id;
  int _idciudad;
  String _imagenUrl;
  String _imagenUrlContentType;
  List<Lotestoanimales> _lotestoanimales;
  String _nombre;
  String _numero;
  double _pesobaseporkg;
  double _pesopromedio;
  double _pesototallote;
  Propietario _propietario;
  String _raza;
  Subastas _subastas;
  String _videoUrl;

  LotesModel(
      {int cantidadAnimales,
      Clasificacionlote clasificacionlote,
      String decripcion,
      int id,
      int idciudad,
      String imagenUrl,
      String imagenUrlContentType,
      List<Lotestoanimales> lotestoanimales,
      String nombre,
      String numero,
      double pesobaseporkg,
      double pesopromedio,
      double pesototallote,
      Propietario propietario,
      String raza,
      Subastas subastas,
      String videoUrl}) {
    this._cantidadAnimales = cantidadAnimales;
    this._clasificacionlote = clasificacionlote;
    this._decripcion = decripcion;
    this._id = id;
    this._idciudad = idciudad;
    this._imagenUrl = imagenUrl;
    this._imagenUrlContentType = imagenUrlContentType;
    this._lotestoanimales = lotestoanimales;
    this._nombre = nombre;
    this._numero = numero;
    this._pesobaseporkg = pesobaseporkg;
    this._pesopromedio = pesopromedio;
    this._pesototallote = pesototallote;
    this._propietario = propietario;
    this._raza = raza;
    this._subastas = subastas;
    this._videoUrl = videoUrl;
  }

  int get cantidadAnimales => _cantidadAnimales;
  set cantidadAnimales(int cantidadAnimales) =>
      _cantidadAnimales = cantidadAnimales;
  Clasificacionlote get clasificacionlote => _clasificacionlote;
  set clasificacionlote(Clasificacionlote clasificacionlote) =>
      _clasificacionlote = clasificacionlote;
  String get decripcion => _decripcion;
  set decripcion(String decripcion) => _decripcion = decripcion;
  int get id => _id;
  set id(int id) => _id = id;
  int get idciudad => _idciudad;
  set idciudad(int idciudad) => _idciudad = idciudad;
  String get imagenUrl => _imagenUrl;
  set imagenUrl(String imagenUrl) => _imagenUrl = imagenUrl;
  String get imagenUrlContentType => _imagenUrlContentType;
  set imagenUrlContentType(String imagenUrlContentType) =>
      _imagenUrlContentType = imagenUrlContentType;
  List<Lotestoanimales> get lotestoanimales => _lotestoanimales;
  set lotestoanimales(List<Lotestoanimales> lotestoanimales) =>
      _lotestoanimales = lotestoanimales;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;
  String get numero => _numero;
  set numero(String numero) => _numero = numero;
  double get pesobaseporkg => _pesobaseporkg;
  set pesobaseporkg(double pesobaseporkg) => _pesobaseporkg = pesobaseporkg;
  double get pesopromedio => _pesopromedio;
  set pesopromedio(double pesopromedio) => _pesopromedio = pesopromedio;
  double get pesototallote => _pesototallote;
  set pesototallote(double pesototallote) => _pesototallote = pesototallote;
  Propietario get propietario => _propietario;
  set propietario(Propietario propietario) => _propietario = propietario;
  String get raza => _raza;
  set raza(String raza) => _raza = raza;
  Subastas get subastas => _subastas;
  set subastas(Subastas subastas) => _subastas = subastas;
  String get videoUrl => _videoUrl;
  set videoUrl(String videoUrl) => _videoUrl = videoUrl;

  LotesModel.fromJson(Map<String, dynamic> json) {
    _cantidadAnimales = json['cantidadAnimales'];
    _clasificacionlote = json['clasificacionlote'] != null
        ? new Clasificacionlote.fromJson(json['clasificacionlote'])
        : null;
    _decripcion = json['decripcion'];
    _id = json['id'];
    _idciudad = json['idciudad'];
    _imagenUrl = json['imagenUrl'];
    _imagenUrlContentType = json['imagenUrlContentType'];
    if (json['lotestoanimales'] != null) {
      _lotestoanimales = new List<Lotestoanimales>();
      json['lotestoanimales'].forEach((v) {
        _lotestoanimales.add(new Lotestoanimales.fromJson(v));
      });
    }
    _nombre = json['nombre'];
    _numero = json['numero'];
    _pesobaseporkg = json['pesobaseporkg'];
    _pesopromedio = json['pesopromedio'];
    _pesototallote = json['pesototallote'];
    _propietario = json['propietario'] != null
        ? new Propietario.fromJson(json['propietario'])
        : null;
    _raza = json['raza'];
    _subastas = json['subastas'] != null
        ? new Subastas.fromJson(json['subastas'])
        : null;
    _videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cantidadAnimales'] = this._cantidadAnimales;
    if (this._clasificacionlote != null) {
      data['clasificacionlote'] = this._clasificacionlote.toJson();
    }
    data['decripcion'] = this._decripcion;
    data['id'] = this._id;
    data['idciudad'] = this._idciudad;
    data['imagenUrl'] = this._imagenUrl;
    data['imagenUrlContentType'] = this._imagenUrlContentType;
    if (this._lotestoanimales != null) {
      data['lotestoanimales'] =
          this._lotestoanimales.map((v) => v.toJson()).toList();
    }
    data['nombre'] = this._nombre;
    data['numero'] = this._numero;
    data['pesobaseporkg'] = this._pesobaseporkg;
    data['pesopromedio'] = this._pesopromedio;
    data['pesototallote'] = this._pesototallote;
    if (this._propietario != null) {
      data['propietario'] = this._propietario.toJson();
    }
    data['raza'] = this._raza;
    if (this._subastas != null) {
      data['subastas'] = this._subastas.toJson();
    }
    data['videoUrl'] = this._videoUrl;
    return data;
  }
}

class Clasificacionlote {
  String _code;
  int _id;
  String _nombre;

  Clasificacionlote({String code, int id, String nombre}) {
    this._code = code;
    this._id = id;
    this._nombre = nombre;
  }

  String get code => _code;
  set code(String code) => _code = code;
  int get id => _id;
  set id(int id) => _id = id;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;

  Clasificacionlote.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _id = json['id'];
    _nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['id'] = this._id;
    data['nombre'] = this._nombre;
    return data;
  }
}

class Lotestoanimales {
  Animales _animales;
  int _cantidad;
  int _id;

  Lotestoanimales({Animales animales, int cantidad, int id}) {
    this._animales = animales;
    this._cantidad = cantidad;
    this._id = id;
  }

  Animales get animales => _animales;
  set animales(Animales animales) => _animales = animales;
  int get cantidad => _cantidad;
  set cantidad(int cantidad) => _cantidad = cantidad;
  int get id => _id;
  set id(int id) => _id = id;

  Lotestoanimales.fromJson(Map<String, dynamic> json) {
    _animales = json['animales'] != null
        ? new Animales.fromJson(json['animales'])
        : null;
    _cantidad = json['cantidad'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._animales != null) {
      data['animales'] = this._animales.toJson();
    }
    data['cantidad'] = this._cantidad;
    data['id'] = this._id;
    return data;
  }
}

class Animales {
  String _descripcion;
  int _id;
  String _imagenUrl;
  String _imagenUrlContentType;
  int _pesokg;
  String _procedencia;
  String _propietario;
  Razas _razas;
  String _sexo;
  String _videoUrl;

  Animales(
      {String descripcion,
      int id,
      String imagenUrl,
      String imagenUrlContentType,
      int pesokg,
      String procedencia,
      String propietario,
      Razas razas,
      String sexo,
      String videoUrl}) {
    this._descripcion = descripcion;
    this._id = id;
    this._imagenUrl = imagenUrl;
    this._imagenUrlContentType = imagenUrlContentType;
    this._pesokg = pesokg;
    this._procedencia = procedencia;
    this._propietario = propietario;
    this._razas = razas;
    this._sexo = sexo;
    this._videoUrl = videoUrl;
  }

  String get descripcion => _descripcion;
  set descripcion(String descripcion) => _descripcion = descripcion;
  int get id => _id;
  set id(int id) => _id = id;
  String get imagenUrl => _imagenUrl;
  set imagenUrl(String imagenUrl) => _imagenUrl = imagenUrl;
  String get imagenUrlContentType => _imagenUrlContentType;
  set imagenUrlContentType(String imagenUrlContentType) =>
      _imagenUrlContentType = imagenUrlContentType;
  int get pesokg => _pesokg;
  set pesokg(int pesokg) => _pesokg = pesokg;
  String get procedencia => _procedencia;
  set procedencia(String procedencia) => _procedencia = procedencia;
  String get propietario => _propietario;
  set propietario(String propietario) => _propietario = propietario;
  Razas get razas => _razas;
  set razas(Razas razas) => _razas = razas;
  String get sexo => _sexo;
  set sexo(String sexo) => _sexo = sexo;
  String get videoUrl => _videoUrl;
  set videoUrl(String videoUrl) => _videoUrl = videoUrl;

  Animales.fromJson(Map<String, dynamic> json) {
    _descripcion = json['descripcion'];
    _id = json['id'];
    _imagenUrl = json['imagenUrl'];
    _imagenUrlContentType = json['imagenUrlContentType'];
    _pesokg = json['pesokg'];
    _procedencia = json['procedencia'];
    _propietario = json['propietario'];
    _razas = json['razas'] != null ? new Razas.fromJson(json['razas']) : null;
    _sexo = json['sexo'];
    _videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descripcion'] = this._descripcion;
    data['id'] = this._id;
    data['imagenUrl'] = this._imagenUrl;
    data['imagenUrlContentType'] = this._imagenUrlContentType;
    data['pesokg'] = this._pesokg;
    data['procedencia'] = this._procedencia;
    data['propietario'] = this._propietario;
    if (this._razas != null) {
      data['razas'] = this._razas.toJson();
    }
    data['sexo'] = this._sexo;
    data['videoUrl'] = this._videoUrl;
    return data;
  }
}

class Razas {
  String _code;
  String _decripcion;
  Especies _especies;
  int _id;
  String _nombre;

  Razas(
      {String code,
      String decripcion,
      Especies especies,
      int id,
      String nombre}) {
    this._code = code;
    this._decripcion = decripcion;
    this._especies = especies;
    this._id = id;
    this._nombre = nombre;
  }

  String get code => _code;
  set code(String code) => _code = code;
  String get decripcion => _decripcion;
  set decripcion(String decripcion) => _decripcion = decripcion;
  Especies get especies => _especies;
  set especies(Especies especies) => _especies = especies;
  int get id => _id;
  set id(int id) => _id = id;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;

  Razas.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _decripcion = json['decripcion'];
    _especies = json['especies'] != null
        ? new Especies.fromJson(json['especies'])
        : null;
    _id = json['id'];
    _nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['decripcion'] = this._decripcion;
    if (this._especies != null) {
      data['especies'] = this._especies.toJson();
    }
    data['id'] = this._id;
    data['nombre'] = this._nombre;
    return data;
  }
}

class Especies {
  String _code;
  String _decripcion;
  int _id;
  String _nombre;

  Especies({String code, String decripcion, int id, String nombre}) {
    this._code = code;
    this._decripcion = decripcion;
    this._id = id;
    this._nombre = nombre;
  }

  String get code => _code;
  set code(String code) => _code = code;
  String get decripcion => _decripcion;
  set decripcion(String decripcion) => _decripcion = decripcion;
  int get id => _id;
  set id(int id) => _id = id;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;

  Especies.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _decripcion = json['decripcion'];
    _id = json['id'];
    _nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['decripcion'] = this._decripcion;
    data['id'] = this._id;
    data['nombre'] = this._nombre;
    return data;
  }
}

class Propietario {
  String _correo;
  String _direccionempresarial;
  String _direccionresidencial;
  int _id;
  int _idciudad;
  String _idusuario;
  String _imagenUrl;
  String _imagenUrlContentType;
  String _nombreORazonSocial;
  int _numeroDocumento;
  String _telefonocelular;
  String _telefonoempresarial;
  String _telefonofijo;
  TipoDocumento _tipoDocumento;

  Propietario(
      {String correo,
      String direccionempresarial,
      String direccionresidencial,
      int id,
      int idciudad,
      String idusuario,
      String imagenUrl,
      String imagenUrlContentType,
      String nombreORazonSocial,
      int numeroDocumento,
      String telefonocelular,
      String telefonoempresarial,
      String telefonofijo,
      TipoDocumento tipoDocumento}) {
    this._correo = correo;
    this._direccionempresarial = direccionempresarial;
    this._direccionresidencial = direccionresidencial;
    this._id = id;
    this._idciudad = idciudad;
    this._idusuario = idusuario;
    this._imagenUrl = imagenUrl;
    this._imagenUrlContentType = imagenUrlContentType;
    this._nombreORazonSocial = nombreORazonSocial;
    this._numeroDocumento = numeroDocumento;
    this._telefonocelular = telefonocelular;
    this._telefonoempresarial = telefonoempresarial;
    this._telefonofijo = telefonofijo;
    this._tipoDocumento = tipoDocumento;
  }

  String get correo => _correo;
  set correo(String correo) => _correo = correo;
  String get direccionempresarial => _direccionempresarial;
  set direccionempresarial(String direccionempresarial) =>
      _direccionempresarial = direccionempresarial;
  String get direccionresidencial => _direccionresidencial;
  set direccionresidencial(String direccionresidencial) =>
      _direccionresidencial = direccionresidencial;
  int get id => _id;
  set id(int id) => _id = id;
  int get idciudad => _idciudad;
  set idciudad(int idciudad) => _idciudad = idciudad;
  String get idusuario => _idusuario;
  set idusuario(String idusuario) => _idusuario = idusuario;
  String get imagenUrl => _imagenUrl;
  set imagenUrl(String imagenUrl) => _imagenUrl = imagenUrl;
  String get imagenUrlContentType => _imagenUrlContentType;
  set imagenUrlContentType(String imagenUrlContentType) =>
      _imagenUrlContentType = imagenUrlContentType;
  String get nombreORazonSocial => _nombreORazonSocial;
  set nombreORazonSocial(String nombreORazonSocial) =>
      _nombreORazonSocial = nombreORazonSocial;
  int get numeroDocumento => _numeroDocumento;
  set numeroDocumento(int numeroDocumento) =>
      _numeroDocumento = numeroDocumento;
  String get telefonocelular => _telefonocelular;
  set telefonocelular(String telefonocelular) =>
      _telefonocelular = telefonocelular;
  String get telefonoempresarial => _telefonoempresarial;
  set telefonoempresarial(String telefonoempresarial) =>
      _telefonoempresarial = telefonoempresarial;
  String get telefonofijo => _telefonofijo;
  set telefonofijo(String telefonofijo) => _telefonofijo = telefonofijo;
  TipoDocumento get tipoDocumento => _tipoDocumento;
  set tipoDocumento(TipoDocumento tipoDocumento) =>
      _tipoDocumento = tipoDocumento;

  Propietario.fromJson(Map<String, dynamic> json) {
    _correo = json['correo'];
    _direccionempresarial = json['direccionempresarial'];
    _direccionresidencial = json['direccionresidencial'];
    _id = json['id'];
    _idciudad = json['idciudad'];
    _idusuario = json['idusuario'];
    _imagenUrl = json['imagenUrl'];
    _imagenUrlContentType = json['imagenUrlContentType'];
    _nombreORazonSocial = json['nombreORazonSocial'];
    _numeroDocumento = json['numeroDocumento'];
    _telefonocelular = json['telefonocelular'];
    _telefonoempresarial = json['telefonoempresarial'];
    _telefonofijo = json['telefonofijo'];
    _tipoDocumento = json['tipoDocumento'] != null
        ? new TipoDocumento.fromJson(json['tipoDocumento'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correo'] = this._correo;
    data['direccionempresarial'] = this._direccionempresarial;
    data['direccionresidencial'] = this._direccionresidencial;
    data['id'] = this._id;
    data['idciudad'] = this._idciudad;
    data['idusuario'] = this._idusuario;
    data['imagenUrl'] = this._imagenUrl;
    data['imagenUrlContentType'] = this._imagenUrlContentType;
    data['nombreORazonSocial'] = this._nombreORazonSocial;
    data['numeroDocumento'] = this._numeroDocumento;
    data['telefonocelular'] = this._telefonocelular;
    data['telefonoempresarial'] = this._telefonoempresarial;
    data['telefonofijo'] = this._telefonofijo;
    if (this._tipoDocumento != null) {
      data['tipoDocumento'] = this._tipoDocumento.toJson();
    }
    return data;
  }
}

class TipoDocumento {
  List<Clientes> _clientes;
  String _codigo;
  int _id;
  String _nombre;

  TipoDocumento(
      {List<Clientes> clientes, String codigo, int id, String nombre}) {
    this._clientes = clientes;
    this._codigo = codigo;
    this._id = id;
    this._nombre = nombre;
  }

  List<Clientes> get clientes => _clientes;
  set clientes(List<Clientes> clientes) => _clientes = clientes;
  String get codigo => _codigo;
  set codigo(String codigo) => _codigo = codigo;
  int get id => _id;
  set id(int id) => _id = id;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;

  TipoDocumento.fromJson(Map<String, dynamic> json) {
    if (json['clientes'] != null) {
      _clientes = new List<Clientes>();
      json['clientes'].forEach((v) {
        _clientes.add(new Clientes.fromJson(v));
      });
    }
    _codigo = json['codigo'];
    _id = json['id'];
    _nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._clientes != null) {
      data['clientes'] = this._clientes.map((v) => v.toJson()).toList();
    }
    data['codigo'] = this._codigo;
    data['id'] = this._id;
    data['nombre'] = this._nombre;
    return data;
  }
}

class Clientes {
  String _apellido;
  String _correo;
  String _direccionempresarial;
  String _direccionrepresentantelegal;
  String _direccionresidencial;
  Clasificacionlote _estadocliente;
  String _fechanacimiento;
  int _id;
  int _idciudad;
  String _idusuario;
  String _imagenUrl;
  String _imagenUrlContentType;
  String _nombre;
  String _nombrerepresentantelegal;
  int _numeroDocumento;
  List<Pujadores> _pujadores;
  String _telefonocelular;
  String _telefonoempresarial;
  String _telefonofijo;
  String _telefonorepresentantelegal;

  Clientes(
      {String apellido,
      String correo,
      String direccionempresarial,
      String direccionrepresentantelegal,
      String direccionresidencial,
      Clasificacionlote estadocliente,
      String fechanacimiento,
      int id,
      int idciudad,
      String idusuario,
      String imagenUrl,
      String imagenUrlContentType,
      String nombre,
      String nombrerepresentantelegal,
      int numeroDocumento,
      List<Pujadores> pujadores,
      String telefonocelular,
      String telefonoempresarial,
      String telefonofijo,
      String telefonorepresentantelegal}) {
    this._apellido = apellido;
    this._correo = correo;
    this._direccionempresarial = direccionempresarial;
    this._direccionrepresentantelegal = direccionrepresentantelegal;
    this._direccionresidencial = direccionresidencial;
    this._estadocliente = estadocliente;
    this._fechanacimiento = fechanacimiento;
    this._id = id;
    this._idciudad = idciudad;
    this._idusuario = idusuario;
    this._imagenUrl = imagenUrl;
    this._imagenUrlContentType = imagenUrlContentType;
    this._nombre = nombre;
    this._nombrerepresentantelegal = nombrerepresentantelegal;
    this._numeroDocumento = numeroDocumento;
    this._pujadores = pujadores;
    this._telefonocelular = telefonocelular;
    this._telefonoempresarial = telefonoempresarial;
    this._telefonofijo = telefonofijo;
    this._telefonorepresentantelegal = telefonorepresentantelegal;
  }

  String get apellido => _apellido;
  set apellido(String apellido) => _apellido = apellido;
  String get correo => _correo;
  set correo(String correo) => _correo = correo;
  String get direccionempresarial => _direccionempresarial;
  set direccionempresarial(String direccionempresarial) =>
      _direccionempresarial = direccionempresarial;
  String get direccionrepresentantelegal => _direccionrepresentantelegal;
  set direccionrepresentantelegal(String direccionrepresentantelegal) =>
      _direccionrepresentantelegal = direccionrepresentantelegal;
  String get direccionresidencial => _direccionresidencial;
  set direccionresidencial(String direccionresidencial) =>
      _direccionresidencial = direccionresidencial;
  Clasificacionlote get estadocliente => _estadocliente;
  set estadocliente(Clasificacionlote estadocliente) =>
      _estadocliente = estadocliente;
  String get fechanacimiento => _fechanacimiento;
  set fechanacimiento(String fechanacimiento) =>
      _fechanacimiento = fechanacimiento;
  int get id => _id;
  set id(int id) => _id = id;
  int get idciudad => _idciudad;
  set idciudad(int idciudad) => _idciudad = idciudad;
  String get idusuario => _idusuario;
  set idusuario(String idusuario) => _idusuario = idusuario;
  String get imagenUrl => _imagenUrl;
  set imagenUrl(String imagenUrl) => _imagenUrl = imagenUrl;
  String get imagenUrlContentType => _imagenUrlContentType;
  set imagenUrlContentType(String imagenUrlContentType) =>
      _imagenUrlContentType = imagenUrlContentType;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;
  String get nombrerepresentantelegal => _nombrerepresentantelegal;
  set nombrerepresentantelegal(String nombrerepresentantelegal) =>
      _nombrerepresentantelegal = nombrerepresentantelegal;
  int get numeroDocumento => _numeroDocumento;
  set numeroDocumento(int numeroDocumento) =>
      _numeroDocumento = numeroDocumento;
  List<Pujadores> get pujadores => _pujadores;
  set pujadores(List<Pujadores> pujadores) => _pujadores = pujadores;
  String get telefonocelular => _telefonocelular;
  set telefonocelular(String telefonocelular) =>
      _telefonocelular = telefonocelular;
  String get telefonoempresarial => _telefonoempresarial;
  set telefonoempresarial(String telefonoempresarial) =>
      _telefonoempresarial = telefonoempresarial;
  String get telefonofijo => _telefonofijo;
  set telefonofijo(String telefonofijo) => _telefonofijo = telefonofijo;
  String get telefonorepresentantelegal => _telefonorepresentantelegal;
  set telefonorepresentantelegal(String telefonorepresentantelegal) =>
      _telefonorepresentantelegal = telefonorepresentantelegal;

  Clientes.fromJson(Map<String, dynamic> json) {
    _apellido = json['apellido'];
    _correo = json['correo'];
    _direccionempresarial = json['direccionempresarial'];
    _direccionrepresentantelegal = json['direccionrepresentantelegal'];
    _direccionresidencial = json['direccionresidencial'];
    _estadocliente = json['estadocliente'] != null
        ? new Clasificacionlote.fromJson(json['estadocliente'])
        : null;
    _fechanacimiento = json['fechanacimiento'];
    _id = json['id'];
    _idciudad = json['idciudad'];
    _idusuario = json['idusuario'];
    _imagenUrl = json['imagenUrl'];
    _imagenUrlContentType = json['imagenUrlContentType'];
    _nombre = json['nombre'];
    _nombrerepresentantelegal = json['nombrerepresentantelegal'];
    _numeroDocumento = json['numeroDocumento'];
    if (json['pujadores'] != null) {
      _pujadores = new List<Pujadores>();
      json['pujadores'].forEach((v) {
        _pujadores.add(new Pujadores.fromJson(v));
      });
    }
    _telefonocelular = json['telefonocelular'];
    _telefonoempresarial = json['telefonoempresarial'];
    _telefonofijo = json['telefonofijo'];
    _telefonorepresentantelegal = json['telefonorepresentantelegal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apellido'] = this._apellido;
    data['correo'] = this._correo;
    data['direccionempresarial'] = this._direccionempresarial;
    data['direccionrepresentantelegal'] = this._direccionrepresentantelegal;
    data['direccionresidencial'] = this._direccionresidencial;
    if (this._estadocliente != null) {
      data['estadocliente'] = this._estadocliente.toJson();
    }
    data['fechanacimiento'] = this._fechanacimiento;
    data['id'] = this._id;
    data['idciudad'] = this._idciudad;
    data['idusuario'] = this._idusuario;
    data['imagenUrl'] = this._imagenUrl;
    data['imagenUrlContentType'] = this._imagenUrlContentType;
    data['nombre'] = this._nombre;
    data['nombrerepresentantelegal'] = this._nombrerepresentantelegal;
    data['numeroDocumento'] = this._numeroDocumento;
    if (this._pujadores != null) {
      data['pujadores'] = this._pujadores.map((v) => v.toJson()).toList();
    }
    data['telefonocelular'] = this._telefonocelular;
    data['telefonoempresarial'] = this._telefonoempresarial;
    data['telefonofijo'] = this._telefonofijo;
    data['telefonorepresentantelegal'] = this._telefonorepresentantelegal;
    return data;
  }
}

class Pujadores {
  String _estado;
  int _id;
  String _nombrebanco;
  String _nroconsignacion;
  List<Pujas> _pujas;

  Pujadores(
      {String estado,
      int id,
      String nombrebanco,
      String nroconsignacion,
      List<Pujas> pujas}) {
    this._estado = estado;
    this._id = id;
    this._nombrebanco = nombrebanco;
    this._nroconsignacion = nroconsignacion;
    this._pujas = pujas;
  }

  String get estado => _estado;
  set estado(String estado) => _estado = estado;
  int get id => _id;
  set id(int id) => _id = id;
  String get nombrebanco => _nombrebanco;
  set nombrebanco(String nombrebanco) => _nombrebanco = nombrebanco;
  String get nroconsignacion => _nroconsignacion;
  set nroconsignacion(String nroconsignacion) =>
      _nroconsignacion = nroconsignacion;
  List<Pujas> get pujas => _pujas;
  set pujas(List<Pujas> pujas) => _pujas = pujas;

  Pujadores.fromJson(Map<String, dynamic> json) {
    _estado = json['estado'];
    _id = json['id'];
    _nombrebanco = json['nombrebanco'];
    _nroconsignacion = json['nroconsignacion'];
    if (json['pujas'] != null) {
      _pujas = new List<Pujas>();
      json['pujas'].forEach((v) {
        _pujas.add(new Pujas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estado'] = this._estado;
    data['id'] = this._id;
    data['nombrebanco'] = this._nombrebanco;
    data['nroconsignacion'] = this._nroconsignacion;
    if (this._pujas != null) {
      data['pujas'] = this._pujas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pujas {
  String _fechacreacion;
  int _id;
  String _idLote;
  String _idSubasta;
  int _valor;

  Pujas(
      {String fechacreacion,
      int id,
      String idLote,
      String idSubasta,
      int valor}) {
    this._fechacreacion = fechacreacion;
    this._id = id;
    this._idLote = idLote;
    this._idSubasta = idSubasta;
    this._valor = valor;
  }

  String get fechacreacion => _fechacreacion;
  set fechacreacion(String fechacreacion) => _fechacreacion = fechacreacion;
  int get id => _id;
  set id(int id) => _id = id;
  String get idLote => _idLote;
  set idLote(String idLote) => _idLote = idLote;
  String get idSubasta => _idSubasta;
  set idSubasta(String idSubasta) => _idSubasta = idSubasta;
  int get valor => _valor;
  set valor(int valor) => _valor = valor;

  Pujas.fromJson(Map<String, dynamic> json) {
    _fechacreacion = json['fechacreacion'];
    _id = json['id'];
    _idLote = json['idLote'];
    _idSubasta = json['idSubasta'];
    _valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fechacreacion'] = this._fechacreacion;
    data['id'] = this._id;
    data['idLote'] = this._idLote;
    data['idSubasta'] = this._idSubasta;
    data['valor'] = this._valor;
    return data;
  }
}

class Subastas {
  String _decripcion;
  Eventos _eventos;
  String _fechacreacion;
  String _fechafinal;
  String _fechainicio;
  int _id;
  String _imagenUrl;
  String _imagenUrlContentType;
  String _nombre;
  bool _pagaAnticipo;
  double _pesobaseporkg;
  double _pesototallote;
  double _valorAnticipo;
  double _valoractual;
  double _valorinicial;
  double _valortope;
  String _videoUrl;

  Subastas(
      {String decripcion,
      Eventos eventos,
      String fechacreacion,
      String fechafinal,
      String fechainicio,
      int id,
      String imagenUrl,
      String imagenUrlContentType,
      String nombre,
      bool pagaAnticipo,
      double pesobaseporkg,
      double pesototallote,
      double valorAnticipo,
      double valoractual,
      double valorinicial,
      double valortope,
      String videoUrl}) {
    this._decripcion = decripcion;
    this._eventos = eventos;
    this._fechacreacion = fechacreacion;
    this._fechafinal = fechafinal;
    this._fechainicio = fechainicio;
    this._id = id;
    this._imagenUrl = imagenUrl;
    this._imagenUrlContentType = imagenUrlContentType;
    this._nombre = nombre;
    this._pagaAnticipo = pagaAnticipo;
    this._pesobaseporkg = pesobaseporkg;
    this._pesototallote = pesototallote;
    this._valorAnticipo = valorAnticipo;
    this._valoractual = valoractual;
    this._valorinicial = valorinicial;
    this._valortope = valortope;
    this._videoUrl = videoUrl;
  }

  String get decripcion => _decripcion;
  set decripcion(String decripcion) => _decripcion = decripcion;
  Eventos get eventos => _eventos;
  set eventos(Eventos eventos) => _eventos = eventos;
  String get fechacreacion => _fechacreacion;
  set fechacreacion(String fechacreacion) => _fechacreacion = fechacreacion;
  String get fechafinal => _fechafinal;
  set fechafinal(String fechafinal) => _fechafinal = fechafinal;
  String get fechainicio => _fechainicio;
  set fechainicio(String fechainicio) => _fechainicio = fechainicio;
  int get id => _id;
  set id(int id) => _id = id;
  String get imagenUrl => _imagenUrl;
  set imagenUrl(String imagenUrl) => _imagenUrl = imagenUrl;
  String get imagenUrlContentType => _imagenUrlContentType;
  set imagenUrlContentType(String imagenUrlContentType) =>
      _imagenUrlContentType = imagenUrlContentType;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;
  bool get pagaAnticipo => _pagaAnticipo;
  set pagaAnticipo(bool pagaAnticipo) => _pagaAnticipo = pagaAnticipo;
  double get pesobaseporkg => _pesobaseporkg;
  set pesobaseporkg(double pesobaseporkg) => _pesobaseporkg = pesobaseporkg;
  double get pesototallote => _pesototallote;
  set pesototallote(double pesototallote) => _pesototallote = pesototallote;
  double get valorAnticipo => _valorAnticipo;
  set valorAnticipo(double valorAnticipo) => _valorAnticipo = valorAnticipo;
  double get valoractual => _valoractual;
  set valoractual(double valoractual) => _valoractual = valoractual;
  double get valorinicial => _valorinicial;
  set valorinicial(double valorinicial) => _valorinicial = valorinicial;
  double get valortope => _valortope;
  set valortope(double valortope) => _valortope = valortope;
  String get videoUrl => _videoUrl;
  set videoUrl(String videoUrl) => _videoUrl = videoUrl;

  Subastas.fromJson(Map<String, dynamic> json) {
    _decripcion = json['decripcion'];
    _eventos =
        json['eventos'] != null ? new Eventos.fromJson(json['eventos']) : null;
    _fechacreacion = json['fechacreacion'];
    _fechafinal = json['fechafinal'];
    _fechainicio = json['fechainicio'];
    _id = json['id'];
    _imagenUrl = json['imagenUrl'];
    _imagenUrlContentType = json['imagenUrlContentType'];
    _nombre = json['nombre'];
    _pagaAnticipo = json['pagaAnticipo'];
    _pesobaseporkg = json['pesobaseporkg'];
    _pesototallote = json['pesototallote'];
    _valorAnticipo = json['valorAnticipo'];
    _valoractual = json['valoractual'];
    _valorinicial = json['valorinicial'];
    _valortope = json['valortope'];
    _videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['decripcion'] = this._decripcion;
    if (this._eventos != null) {
      data['eventos'] = this._eventos.toJson();
    }
    data['fechacreacion'] = this._fechacreacion;
    data['fechafinal'] = this._fechafinal;
    data['fechainicio'] = this._fechainicio;
    data['id'] = this._id;
    data['imagenUrl'] = this._imagenUrl;
    data['imagenUrlContentType'] = this._imagenUrlContentType;
    data['nombre'] = this._nombre;
    data['pagaAnticipo'] = this._pagaAnticipo;
    data['pesobaseporkg'] = this._pesobaseporkg;
    data['pesototallote'] = this._pesototallote;
    data['valorAnticipo'] = this._valorAnticipo;
    data['valoractual'] = this._valoractual;
    data['valorinicial'] = this._valorinicial;
    data['valortope'] = this._valortope;
    data['videoUrl'] = this._videoUrl;
    return data;
  }
}

class Eventos {
  String _decripcion;
  String _fechacreacion;
  String _fechafinal;
  String _fechainicio;
  int _id;
  int _idciudad;
  String _imagenUrl;
  String _imagenUrlContentType;
  String _latitud;
  String _longitud;
  String _nombre;
  String _videoUrl;

  Eventos(
      {String decripcion,
      String fechacreacion,
      String fechafinal,
      String fechainicio,
      int id,
      int idciudad,
      String imagenUrl,
      String imagenUrlContentType,
      String latitud,
      String longitud,
      String nombre,
      String videoUrl}) {
    this._decripcion = decripcion;
    this._fechacreacion = fechacreacion;
    this._fechafinal = fechafinal;
    this._fechainicio = fechainicio;
    this._id = id;
    this._idciudad = idciudad;
    this._imagenUrl = imagenUrl;
    this._imagenUrlContentType = imagenUrlContentType;
    this._latitud = latitud;
    this._longitud = longitud;
    this._nombre = nombre;
    this._videoUrl = videoUrl;
  }

  String get decripcion => _decripcion;
  set decripcion(String decripcion) => _decripcion = decripcion;
  String get fechacreacion => _fechacreacion;
  set fechacreacion(String fechacreacion) => _fechacreacion = fechacreacion;
  String get fechafinal => _fechafinal;
  set fechafinal(String fechafinal) => _fechafinal = fechafinal;
  String get fechainicio => _fechainicio;
  set fechainicio(String fechainicio) => _fechainicio = fechainicio;
  int get id => _id;
  set id(int id) => _id = id;
  int get idciudad => _idciudad;
  set idciudad(int idciudad) => _idciudad = idciudad;
  String get imagenUrl => _imagenUrl;
  set imagenUrl(String imagenUrl) => _imagenUrl = imagenUrl;
  String get imagenUrlContentType => _imagenUrlContentType;
  set imagenUrlContentType(String imagenUrlContentType) =>
      _imagenUrlContentType = imagenUrlContentType;
  String get latitud => _latitud;
  set latitud(String latitud) => _latitud = latitud;
  String get longitud => _longitud;
  set longitud(String longitud) => _longitud = longitud;
  String get nombre => _nombre;
  set nombre(String nombre) => _nombre = nombre;
  String get videoUrl => _videoUrl;
  set videoUrl(String videoUrl) => _videoUrl = videoUrl;

  Eventos.fromJson(Map<String, dynamic> json) {
    _decripcion = json['decripcion'];
    _fechacreacion = json['fechacreacion'];
    _fechafinal = json['fechafinal'];
    _fechainicio = json['fechainicio'];
    _id = json['id'];
    _idciudad = json['idciudad'];
    _imagenUrl = json['imagenUrl'];
    _imagenUrlContentType = json['imagenUrlContentType'];
    _latitud = json['latitud'];
    _longitud = json['longitud'];
    _nombre = json['nombre'];
    _videoUrl = json['videoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['decripcion'] = this._decripcion;
    data['fechacreacion'] = this._fechacreacion;
    data['fechafinal'] = this._fechafinal;
    data['fechainicio'] = this._fechainicio;
    data['id'] = this._id;
    data['idciudad'] = this._idciudad;
    data['imagenUrl'] = this._imagenUrl;
    data['imagenUrlContentType'] = this._imagenUrlContentType;
    data['latitud'] = this._latitud;
    data['longitud'] = this._longitud;
    data['nombre'] = this._nombre;
    data['videoUrl'] = this._videoUrl;
    return data;
  }
}