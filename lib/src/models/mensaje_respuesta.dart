
class MensajeRespuesta {
  String mensaje;

  MensajeRespuesta({
    this.mensaje,
  });

  MensajeRespuesta.fromJsonMap(Map<String, dynamic> json){
    mensaje = json['mensaje'];
  }
  
}
