class Servicios {
  List<Servicio> items = new List();
  Servicios();
  Servicios.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    for(var item in jsonList){
      final servicio = new Servicio.fromJsonMap(item);
      items.add(servicio);
    }
  }
}

class Servicio {
  int idServicio;
  String nombre;
  bool check;

  Servicio({
    this.idServicio,
    this.nombre,
  });

  Servicio.fromJsonMap(Map<String, dynamic> json){
    idServicio = json['idServicio'];
    nombre = json['nombre'];
  }
  
}
