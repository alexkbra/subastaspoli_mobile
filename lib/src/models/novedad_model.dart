class Novedades{
  List<Novedad> items = new List();
  Novedades();
  Novedades.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    for(var item in jsonList){
      final novedad = new Novedad.fromJsonMap(item);
      items.add(novedad);
    }
  }

}

class Novedad {
  int idNovedad;
  String titulo;
  String subtitulo;
  String descripcion;
  String imagen;
  List<dynamic> usuarioList;
  List<dynamic> contenidoList;

  Novedad({
    this.idNovedad,
    this.titulo,
    this.subtitulo,
    this.descripcion,
    this.imagen,
    this.usuarioList,
    this.contenidoList,
  });

  Novedad.fromJsonMap(Map<String, dynamic> json) {
    idNovedad = json['idNovedad'];
    titulo = json['titulo'];
    subtitulo = json['subtitulo'];
    descripcion = json['descripcion'];
    imagen = json['imagen'];
    usuarioList = json['usuarioList'];
    contenidoList = json['contenidoList'];
  }
}
