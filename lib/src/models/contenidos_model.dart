
class ContenidosModelList{
  List<ContenidosModel> items = new List();
  ContenidosModelList();
  ContenidosModelList.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    for(var item in jsonList){
      final novedad = new ContenidosModel.fromJson(item);
      items.add(novedad);
    }
  }

}

class ContenidosModel {
  String _entidad;
  int _id;
  String _idEntidad;
  String _imagenUrl;
  String _imagenUrlContentType;
  String _texto;
  String _tipo;
  String _url;

  ContenidosModel(
      {String entidad,
      int id,
      String idEntidad,
      String imagenUrl,
      String imagenUrlContentType,
      String texto,
      String tipo,
      String url}) {
    this._entidad = entidad;
    this._id = id;
    this._idEntidad = idEntidad;
    this._imagenUrl = imagenUrl;
    this._imagenUrlContentType = imagenUrlContentType;
    this._texto = texto;
    this._tipo = tipo;
    this._url = url;
  }

  String get entidad => _entidad;
  set entidad(String entidad) => _entidad = entidad;
  int get id => _id;
  set id(int id) => _id = id;
  String get idEntidad => _idEntidad;
  set idEntidad(String idEntidad) => _idEntidad = idEntidad;
  String get imagenUrl => _imagenUrl;
  set imagenUrl(String imagenUrl) => _imagenUrl = imagenUrl;
  String get imagenUrlContentType => _imagenUrlContentType;
  set imagenUrlContentType(String imagenUrlContentType) =>
      _imagenUrlContentType = imagenUrlContentType;
  String get texto => _texto;
  set texto(String texto) => _texto = texto;
  String get tipo => _tipo;
  set tipo(String tipo) => _tipo = tipo;
  String get url => _url;
  set url(String url) => _url = url;

  ContenidosModel.fromJson(Map<String, dynamic> json) {
    _entidad = json['entidad'];
    _id = json['id'];
    _idEntidad = json['idEntidad'];
    _imagenUrl = json['imagenUrl'];
    _imagenUrlContentType = json['imagenUrlContentType'];
    _texto = json['texto'];
    _tipo = json['tipo'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entidad'] = this._entidad;
    data['id'] = this._id;
    data['idEntidad'] = this._idEntidad;
    data['imagenUrl'] = this._imagenUrl;
    data['imagenUrlContentType'] = this._imagenUrlContentType;
    data['texto'] = this._texto;
    data['tipo'] = this._tipo;
    data['url'] = this._url;
    return data;
  }
}