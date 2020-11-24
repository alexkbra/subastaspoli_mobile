class PujaVM {
  String idEventos;
  String idSubasta;
  String idLote;
  String fechaCreacion;
  String valor;
  String dispositivoId;
  String token;

  PujaVM(
      {this.idEventos,
      this.idSubasta,
      this.idLote,
      this.valor,
      this.dispositivoId,
      this.token});

  PujaVM.fromJson(Map<String, dynamic> json) {
    idEventos = json['idEventos'];
    idSubasta = json['idSubasta'];
    idLote = json['idLote'];
    valor = json['valor'];
    dispositivoId = json['dispositivoId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idEventos'] = this.idEventos;
    data['idSubasta'] = this.idSubasta;
    data['idLote'] = this.idLote;
    data['valor'] = this.valor;
    data['dispositivoId'] = this.dispositivoId;
    data['token'] = this.token;
    return data;
  }
}
